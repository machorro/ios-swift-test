//
//  NewNoteViewController.swift
//  TestApp
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    // MARK: - UI
    
    let textView = UITextView()
    
    // MARK: - Variables
    
    var saveNote: (String) -> Void = { _ in }
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.textView.becomeFirstResponder()
        self.textView.delegate = self
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.textView)
        
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.textView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 12),
                self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
                self.textView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -12),
                self.textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                ])
        }
        else {
            NSLayoutConstraint.activate([
                self.textView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12),
                self.textView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 12),
                self.textView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12),
                self.textView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -12),
                ])
        }

        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveNoteButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func save() {
        guard let text = textView.text else { return }
        self.textView.resignFirstResponder()
        saveNote(text)
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
