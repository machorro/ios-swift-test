//
//  NotesNavigationController.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NotesNavigationController: UINavigationController {
    
    let presenter = NotesPresenter(dataSource: MockNotesDataSource())
    
    let root = NotesViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        showRoot()
    }
    
    private func showRoot() {
        root.presenter = presenter
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        root.navigationItem.setRightBarButton(addButton, animated: false)
        
        self.pushViewController(root, animated: true)
    }
    
    @objc func addNewNote() {
        let vc = NewNoteViewController()
        
        vc.saveNote = { content in
            let note = Note(content: content, creationDate: Date())
            self.presenter.dataSource.add(note: note)
            self.root.tableView.reloadData()
        }
        
        self.pushViewController(vc, animated: true)
    }
}
