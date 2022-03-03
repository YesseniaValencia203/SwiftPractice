//
//  ViewController.swift
//  BreweryAPI
//
//  Created by Consultant on 3/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var breweries = [Brewery]()
    
    override func viewDidLoad() {
        setupDelegates()
        fetchData()
        super.viewDidLoad()
    }
    
    func setupDelegates() {
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    func fetchData() {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "No idea what happened here!")")
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Not a valid HTTP URL response")
                return
            }
            
            // response status
            print("Response Status Code: \(httpResponse.statusCode)")
            print("Response Status debugDescription: \(httpResponse.debugDescription)")
            print("Response Status localizedString: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
            
            // parse the result as JSON
            do {
                guard let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: []) else { return }
                guard let jsonArray = jsonData as? [Any] else { return }
               // print(jsonData)
                
                for brewski in jsonArray {
                    // represents the data as an array of dictionary pairs
                    guard let breweryDict = brewski as? [String:Any] else { return }
                    // assign properties
                    guard let name = breweryDict["name"] as? String else { return }
                    guard let type = breweryDict["brewery_type"] as? String else { return }
                    guard let city = breweryDict["city"] as? String else { return }
                    guard let state = breweryDict["state"] as? String else { return }
                    guard let country = breweryDict["country"] as? String else { print("country")
                        return }
                    guard let postalCode = breweryDict["postal_code"] as? String else { print("postalCode")
                        return }
                    guard let street = breweryDict["street"] as? String else { print("street")
                        return }
                    guard let phone = breweryDict["phone"] as? String else { print("phone")
                        return }




                    /*
                    print(name)
                    print(type)
                    print(city)
                    print(state)
                    print(".....")
                     */
                    self.breweries.append(Brewery(name: name, type: type, city: city, state: state, postalCode: postalCode, street: street, country: country, phone: phone))
                    
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                 
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBreweryDetails" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableview.indexPath(for: cell) {
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.name = breweries[indexPath.row].name
                detailViewController.street = breweries[indexPath.row].street
                detailViewController.city  = "\(breweries[indexPath.row].city), \(breweries[indexPath.row].state) \(breweries[indexPath.row].postalCode)"
                detailViewController.country = breweries[indexPath.row].country
                detailViewController.address = "\(breweries[indexPath.row].street)\n\(breweries[indexPath.row].city), \(breweries[indexPath.row].state) \(breweries[indexPath.row].postalCode)\n\(breweries[indexPath.row].country)"
                detailViewController.phone = breweries[indexPath.row].phone
                
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breweries[indexPath.row].name
        cell.detailTextLabel?.text = "\(breweries[indexPath.row].city), \(breweries[indexPath.row].state)"
        return cell
    }
    
}
