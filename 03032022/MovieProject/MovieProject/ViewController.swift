//
//  ViewController.swift
//  MovieProject
//
//  Created by Consultant on 3/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var movie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movies"
      //  configurePath()
        setupDelegates()
        fetchMovies()
        // Do any additional setup after loading the view.
    }
    
    func setupDelegates() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func fetchMovies() {
        
        URLSession.shared.getRequest(url: APIEndpoints.movies, decoding: Page.self) { [weak self] result in
            switch result {
            case .success(let m):
                self?.movie = m.results!
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movie[indexPath.row].title?.capitalized
        cell.detailTextLabel?.text = "\((movie[indexPath.row].vote_average) ?? 0.0)"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.movie = movie[(tableview.indexPathForSelectedRow?.row)!]
        }
    }

}

