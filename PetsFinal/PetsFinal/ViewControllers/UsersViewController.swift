//
//  UsersViewController.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import UIKit

class UsersViewController: UIViewController {
    let database = DatabaseHandler()
    @IBOutlet weak var tableview: UITableView!
    
    var users: [User]? {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegates()

        // Do any additional setup after loading the view.
    }
    func configureDelegates() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let results = database.fetch(User.self)
        users = database.fetch(User.self)
        print(results.map { $0.firstName })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIHandler.shared.syncUsers { [weak self] in
            self?.users = self?.database.fetch(User.self)
        }
    }
    

}
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UsersTableViewCell
        guard let user = users?[indexPath.row] else { return cell }
        let firstName = user.firstName
        let lastName = user.lastName
        let userID = user.id
        cell.userNameLabel?.text = "\(firstName) \(lastName)"
        cell.userIDLabel?.text = "\(userID)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch(editingStyle) {
        case .insert:
            print("inserting...")
        case .delete:
            print("deleting...")
            guard let user = users?[indexPath.row] else { return }
            // begins a series of method calls that insert, delete, or select rows and sections of the table view
            tableview.beginUpdates()
            users?.remove(at: indexPath.row)
            // delete user from Core Data
            database.delete(user)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            // Concludes series of method calls that insert, delete, select or reload rows and sections of the table view
            tableview.endUpdates()
        default:
            break
        }
    }
}
