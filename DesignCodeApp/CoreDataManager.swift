//
//  CoreDataManager.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 20/04/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import CoreData

extension NSEntityDescription {
    static func object<T : NSManagedObject> (into context : NSManagedObjectContext) -> T {
        return insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
    }
}

extension Section {
    func configure(with codable : SectionCodable) {
        body = codable.body
        caption = codable.caption
        chapterNumber = codable.chapterNumber
        id = codable.id
        title = codable.title
        imageName = codable.imageName
        publishDate = codable.publishDate
    }
}

extension Part {
    func configure(with codable : PartCodable) {
        content = codable.content
        id = codable.id
        title = codable.title
        type = codable.typeName
    }
}


class CoreDataManager {
    
    func loadFromData() {
        
        let contentAPI = ContentAPI.shared
        
        let bookmarksCodable = contentAPI.bookmarks
        let sectionsCodable = contentAPI.sections
        let partsCodable = contentAPI.parts
        
        // Parse them
        for sectionCodable in sectionsCodable {
            
            let section : Section = NSEntityDescription.object(into: contex)
            section.configure(with: sectionCodable)
            
            let bookmarksforThisSection = bookmarksCodable.filter {  $0.sectionId == section.id }
            
            // Parse the parts
            for partCodable in partsCodable {
                
                let part : Part = NSEntityDescription.object(into: contex)
                part.configure(with: partCodable)
                
                section.addToPart(part)
                
                for candidate in bookmarksforThisSection {
                    
                    if candidate.partId == part.id {
                        let bookmark : Bookmark = NSEntityDescription.object(into: contex)
                        
                        bookmark.part = part
                        bookmark.section = section
                        
                        break
                    }
                }
            }
        }
        
        saveContext()
    }
    
    func fetch<T : NSFetchRequestResult>(entityName : String, ofType coreDataType : T.Type) -> Array<T> {
        
        do {
            let entities = try contex.fetch(NSFetchRequest<T>(entityName: entityName))
            return entities
            
        } catch {
            print( error)
        }
        
        return []
    }
    
    lazy var bookmarks : Array<Bookmark> = fetch(entityName: "Bookmark", ofType: Bookmark.self)
    
    func remove(_ bookmark: Bookmark) {
        contex.delete(bookmark)
        saveContext()
        bookmarks = fetch(entityName: "Bookmark", ofType: Bookmark.self)
    }
    
    lazy var sections : Array<Section> = fetch(entityName: "Section", ofType: Section.self)
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
        
    } ()
    
    var contex : NSManagedObjectContext { return persistentContainer.viewContext }
    
    func saveContext() {
        if contex.hasChanges {
            do {
                try contex.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
}
