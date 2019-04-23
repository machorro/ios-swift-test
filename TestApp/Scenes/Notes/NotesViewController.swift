//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - UI
    
    let tableView = UITableView()

    // MARK: - Variables

    var presenter: INotesPresenter?

    // MARK: - Override
    
    override func loadView() {
        super.loadView()
        self.view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        presenter?.fetchNotes { [weak tableView] in
            DispatchQueue.main.async {
                tableView?.reloadData()
            }
        }
    }
    
    private func configureViewController() {
        self.title = "Notes"
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = presenter?.item(at: indexPath.row) else { return UITableViewCell() }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = item.content
        cell.detailTextLabel?.text = "\(item.creationDate)"
        
        return cell
    }
}
