//
//  NoteTests.swift
//  TestAppTests
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import XCTest
@testable import TestApp

class NoteTests: XCTestCase {
    
    let date = Date(timeIntervalSinceNow: -29605.588421940804)
    var dataSource: NotesDataSource!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = MockNotesDataSource()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSource = nil
    }

    func test_NoteContentIsEmptyIsTrue() {
        let note = Note(content: "")
        
        XCTAssertTrue(note.content.isEmpty)
    }
    
    func test_NoteContentIsEmptyIsFalse() {
        let note = Note(content: "This is a Note")
        XCTAssertFalse(note.content.isEmpty)
    }
    
    func test_NoteDefaultCreationDateIsNotEqualToApril22At2PM() {
        let note = Note(content: "This is a Note")
        XCTAssertNotEqual(date, note.creationDate)
    }
    
    func test_NoteCreationDateIsEqualToApril22At2PM() {
        let note = Note(content: "This is a Note", creationDate: date)
        XCTAssertEqual(date, note.creationDate)
    }
    
    func test_NotesDataSourceNotesIsEmptyIsFalse() {
        let expectation = self.expectation(description: "Fetching Notes")
        dataSource.fetchNotes(expectation.fulfill)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(dataSource.notes.isEmpty)
    }
    
    func test_NotesAreSortedByNewerDateIsTrue() {
        let expectation = self.expectation(description: "Fetching Notes")
        dataSource.fetchNotes(expectation.fulfill)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(dataSource.notes.first!.creationDate > dataSource.notes.last!.creationDate)
    }
}
