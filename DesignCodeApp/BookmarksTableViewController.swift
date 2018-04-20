//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 19/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class BookmarksTableViewController: UITableViewController {
    
   var bookmarks : Array<Bookmark> { return CoreDataManager.shared.bookmarks }
    
   var sections : Array<Section> { return CoreDataManager.shared.sections }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell") as! BookmarksTableViewCell
        
        let bookmark = bookmarks[indexPath.row]
        
        let part = bookmark.part!
        let section = bookmark.section!
        
        cell.chapterTitleLabel.text = section.title!.uppercased()
        cell.titleLabel.text = part.title
        cell.bodyLabel.text = part.content
        cell.chapterNumberLabel.text = section.chapterNumber
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + (part.type ?? "text"))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            
            let bookmark = bookmarks[indexPath.row]
            CoreDataManager.shared.remove(bookmark)
            
            tableView.deleteRows(at: [indexPath], with: .top)
            tableView.endUpdates()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Bookmarks to Section", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Bookmarks to Section", let destination = segue.destination as? SectionViewController {
            destination.section = sections[0]
            destination.sections = sections
            destination.indexPath = sender as! IndexPath
        }
    }
    
}

extension UIViewController {
    
    @IBAction public func unwindToViewController (_ segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
