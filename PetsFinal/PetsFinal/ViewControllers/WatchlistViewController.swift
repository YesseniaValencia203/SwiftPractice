//
//  WatchlistViewController.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import UIKit
import CloudKit

class WatchlistViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    let database = DatabaseHandler()
    
    var petList: [Pet]? {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()

        // Do any additional setup after loading the view.
    }
    func setupDelegates() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        petList = database.fetch(Pet.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        petList = database.fetch(Pet.self)
    }
    

}
extension WatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePet") as! WatchlistTableViewCell
        cell.pet = petList?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print("inserting...")
        case .delete:
            print("deleting...")
            guard let pokemon = petList?[indexPath.row] else { return }
            tableview.beginUpdates()
            petList?.remove(at: indexPath.row)
            database.delete(pokemon)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        default:
            break
        }
        
    }
}

