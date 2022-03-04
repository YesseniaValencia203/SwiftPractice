//
//  DetailViewController.swift
//  MovieProject
//
//  Created by Consultant on 3/3/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var movie: Movie?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageConfigurationForPath()

        movieDescription.text = movie?.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: (movie?.release_date)!)
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: date!)
        movieYear.text = year
        self.navigationItem.title = movie?.title
    }
    func imageConfigurationForPath() {
        let apiUrl = "https://api.themoviedb.org/3/configuration?api_key=\(APIEndpoints.apiKey)"
        let url = URL(string: apiUrl)
        URLSession.shared.getRequest(url: url, decoding: ImageConfig.self) { [weak self] response in
            switch response {
            case .success(let config):
                let newPath = "\((config.images?.secure_base_url)!)\((config.images?.poster_sizes?[2])!)\((self?.movie?.poster_path)!)"
                self?.movieImage.getImage(from: URL(string: newPath)!)
            case .failure(let error):
                print(error)
            
            }
        }
        
    }
}

