//
//  ViewController.swift
//  MapAssignment
//
//  Created by Consultant on 3/23/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var baseURL: String = "https://randomuser.me/api/?results=100"
    var userResults: [ResultResponse] = [ResultResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        fetchUsers()
        // Do any additional setup after loading the view.
    }

    func fetchUsers() {
        URLSession.shared.getRequest(url: URL(string: baseURL), decoding: ResultsResponse.self) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let pageResults):
                DispatchQueue.main.async {
                    self?.userResults = pageResults.results!
                    self?.tableview.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            let user = userResults[(tableview.indexPathForSelectedRow?.row)!]
            guard let lat = user.location?.coordinates?.latitude else {
                print("No value for latitude")
                return
                
            }
            guard let long = user.location?.coordinates?.longitude else {
                print("No value for longitude")
                return
            }
            var latDouble = Double(lat)!
            var longDouble = Double(long)!
            print(latDouble)
            print(longDouble)
            let initial = CLLocation(latitude: latDouble, longitude: longDouble)
            let initialLocation = CLLocationCoordinate2D(latitude: latDouble, longitude: longDouble )
            destination.mapView?.centerToLocation(initial)
            
            //destination.mapView?.setCenter(initialLocation, animated: true)
            /*
            let region = MKCoordinateRegion(center: initial.coordinate, latitudinalMeters: 5000, longitudinalMeters: 6000)
            destination.mapView?.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 20000)
            destination.mapView?.setCameraZoomRange(zoomRange, animated: true)
            //destination.initialLocation = initialLocation
            
*/
        }
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let user = userResults[indexPath.row]
        var firstName = user.name?.first
        var lastName = user.name?.last
        print(user.location?.coordinates?.longitude)


        cell.userNameLabel.text = "\(firstName!.capitalized) \(lastName!.capitalized)"
        cell.userEmailLabel.text = user.email
        cell.userImageView.getImage(from: (user.picture?.thumbnail)!)
        return cell
    }
}
