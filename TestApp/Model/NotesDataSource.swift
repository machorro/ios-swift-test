//
//  NotesDataSource.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol NotesDataSource {
    var notes: [Note] { get }
    mutating func fetchNotes(_ completion: () -> Void)
    mutating func add(content: String, creationDate: Date)
    mutating func delete(at index: Int)
    mutating func update(_ note: Note, with content: String)
}

class CoreDataNoteDataSource: NotesDataSource {
    var notes: [Note] = []
    
    func fetchNotes(_ completion: () -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = Note.createFetchRequest()
        
        do {
            notes = try managedContext
                        .fetch(fetchRequest)
                        .sorted(by: {
                            $0.creationDate.compare($1.creationDate as Date) == .orderedDescending
                        })
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func add(content: String, creationDate: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let note = Note(context: managedContext)
        note.content = content
        note.creationDate = creationDate as NSDate
        
        do {
            try managedContext.save()
            notes.insert(note, at: 0)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(at index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let note = notes[index]
        
        do {
            managedContext.delete(note)
            notes.remove(at: index)
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update(_ note: Note, with content: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        note.content = content
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}
