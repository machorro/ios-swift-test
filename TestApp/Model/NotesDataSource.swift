//
//  NotesDataSource.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

protocol NotesDataSource {
    var notes: [Note] { get }
    mutating func fetchNotes(_ completion: () -> Void)
    mutating func add(note: Note)
}

struct MockNotesDataSource: NotesDataSource {
    private(set) var notes: [Note] = []
    
    mutating func fetchNotes(_ completion: () -> Void) {
        notes = mockNotes()
        completion()
    }
    
    mutating func add(note: Note) {
        notes.insert(note, at: 0)
    }
}

extension MockNotesDataSource {
    private func mockNotes() -> [Note] {
        let referenceDate = Date()
        return (1...100).map {
            Note(content: "This is mock note #\($0)",
                creationDate: Date(timeIntervalSinceReferenceDate: .random(in: 0...referenceDate.timeIntervalSinceReferenceDate)))
            }
            .sorted(by: {
                return $0.creationDate > $1.creationDate
            })
    }
}
