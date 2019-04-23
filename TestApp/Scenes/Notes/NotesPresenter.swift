//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter: AnyObject {
    var count: Int { get }
    var dataSource: NotesDataSource { get }
    func item(at index: Int) -> Note
    func fetchNotes(_ completion: () -> Void)
}

class NotesPresenter: INotesPresenter {
    
    var count: Int { return dataSource.notes.count }
    var dataSource: NotesDataSource
    
    init(dataSource: NotesDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchNotes(_ completion: () -> Void) {
        dataSource.fetchNotes(completion)
    }
    
    func item(at index: Int) -> Note {
        return dataSource.notes[index]
    }
}
