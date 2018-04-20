//
//  ContentAPI.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 20/04/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

struct BookmarkCodable : Codable {
    var sectionId : String
    var partId : String
}


struct SectionCodable : Codable {
    
    var id : String
    var chapterNumber : String
    var title : String
    var caption : String
    var body : String
    var imageName : String
    var publishDate : Date
    
}

struct PartCodable : Codable {
    
    var id : String
    var typeName : String
    var title : String
    var content : String
}

class ContentAPI {
    
    static var shared : ContentAPI = ContentAPI()
    
    lazy var bookmarks : Array<BookmarkCodable> = {
        return load(into: Array<BookmarkCodable>.self, resource: "Bookmarks") ?? []
    }()
    
    lazy var sections : Array<SectionCodable> = {
        return load(into: Array<SectionCodable>.self, resource: "Sections") ?? []
    }()
    
    lazy var parts : Array<PartCodable> = {
        return load(into: Array<PartCodable>.self, resource: "Parts") ?? []
    }()
    
    
    func load<T : Codable>(into swiftType : T.Type, resource : String, ofType type : String = "json") -> T? {
        
        let path = Bundle.main.path(forResource: resource, ofType: type)
        let url = URL(fileURLWithPath: path!)
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return try! decoder.decode(swiftType.self, from: data)
    }
        
}
