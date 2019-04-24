//
//  NotesNavigationController.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NotesNavigationController: UINavigationController {
    
    let presenter = NotesPresenter(dataSource: CoreDataNoteDataSource())
    
    let root = NotesViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        showRoot()
        setupSearchController()
    }
    
    private func showRoot() {
        root.presenter = presenter
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        root.navigationItem.setRightBarButton(addButton, animated: false)
        
        root.selectNoteAt = { [unowned self] index in
            self.edit(note: self.presenter.item(at: index))
        }
        
        self.pushViewController(root, animated: true)
    }
    
    @objc func addNewNote() {
        let vc = NewNoteViewController()
        
        vc.saveNote = { content in
            self.presenter.dataSource.add(content: content, creationDate: Date())
            self.root.tableView.reloadData()
        }
        
        self.pushViewController(vc, animated: true)
    }
    
    func edit(note: Note) {
        let vc = NewNoteViewController()
        vc.textView.text = note.content
        
        vc.saveNote = { [unowned self] content in
            self.presenter.dataSource.update(note, with: content)
            self.root.tableView.reloadData()
        }
        
        self.pushViewController(vc, animated: true)
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search for a Note"
        search.searchBar.autocapitalizationType = .none

        if #available(iOS 11.0, *) {
            root.navigationItem.searchController = search
        }
        else {
            root.tableView.tableHeaderView = search.searchBar
        }
        self.root.definesPresentationContext = true
    }
}

extension NotesNavigationController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text.isEmpty {
            root.presenter = presenter
            root.tableView.reloadData()
            return
        }
        
        let filteredNotes = presenter.dataSource.notes.filter {
            $0.content.contains(text)
        }
        
        let dataSource = CoreDataNoteDataSource()
        dataSource.notes = filteredNotes
        root.presenter = NotesPresenter(dataSource: dataSource)
        
        root.tableView.reloadData()
    }
}
