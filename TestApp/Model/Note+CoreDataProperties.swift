//
//  NoteEntity+CoreDataProperties.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-23.
//  Copyright © 2019 AlayaCare. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String
    @NSManaged public var creationDate: NSDate

}
