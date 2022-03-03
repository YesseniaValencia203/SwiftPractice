//
//  ViewController.swift
//  Brewery2
//
//  Created by Consultant on 3/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var breweries: [Brewery] =  [Brewery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    func setupTableView() {
        fetchJson {
            self.tableview.reloadData()
        }
        tableview.delegate = self
        tableview.dataSource = self
    }

    func fetchJson(completed: @escaping () -> ()) {
        guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something strange happened")")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard data != nil else {
                print("Error: We have no data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.breweries = try decoder.decode([Brewery].self, from: data!)
                DispatchQueue.main.async {
                    completed()
                }
            } catch {
                print("mistake")
                
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breweries[indexPath.row].name?.capitalized
        cell.detailTextLabel?.text = "\((breweries[indexPath.row].city) ?? ""), \((breweries[indexPath.row].state) ?? "")"
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.brewery = breweries[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
}
