//
//  SecondTabViewController.swift
//  TopAlbums
//
//  Created by Consultant on 2/27/22.
//

import UIKit

class SecondTabViewController: UIViewController {
    var albumView = UITableView()
    var albums: [Album] = []
    let albumCell = "albumCell"
    

    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Top Rock Albums of the 2010's"
        configureTableView()
        setTableViewDelegates()
        albums = fetchData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        view.addSubview(albumView)
        albumView.rowHeight = 100
        albumView.register(AlbumTableViewCell.self, forCellReuseIdentifier: albumCell)
        albumView.pin(view)
        
    }
    func setTableViewDelegates() {
        albumView.delegate = self
        albumView.dataSource = self
    }
    

}
extension SecondTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumView.dequeueReusableCell(withIdentifier: albumCell) as! AlbumTableViewCell
        let album = albums[indexPath.row]
        cell.set(album)
        
        return cell
    }
}
extension SecondTabViewController {
    func fetchData() -> [Album] {
        let albums = [
            Album(albumImage: Images.davidBowieBlackstar, albumTitle: "Blackstar", artistName: "David Bowie", artistImage: Images.davidBowie, artistDetails: "TBD"),
            Album(albumImage: Images.davidBowieTheNextDay, albumTitle: "The Next Day", artistName: "David Bowie", artistImage: Images.davidBowie, artistDetails: "TBD"),
            Album(albumImage: Images.rollingStonesBlueAndLonesome, albumTitle: "Blue and Lonesome", artistName: "The Rolling Stones", artistImage: Images.rollingStones, artistDetails: "TBD"),
            Album(albumImage: Images.paulSimonSoBeautifulSoWhat, albumTitle: "So Beautiful Or So What", artistName: "Paul Simon", artistImage: Images.paulSimon, artistDetails: "TBD"),
            Album(albumImage: Images.jackWhiteBlunderbuss, albumTitle: "Blunderbuss", artistName: "Jack White", artistImage: Images.jackWhite, artistDetails: "TBD"),
            Album(albumImage: Images.blackKeysBrothers, albumTitle: "Brothers", artistName: "The Black Keys", artistImage: Images.blackKeys, artistDetails: "TBD"),
            Album(albumImage: Images.iggyPopPostPopDepression, albumTitle: "Post Pop Depression", artistName: "Iggy Pop", artistImage: Images.iggyPop, artistDetails: "TBD"),
            Album(albumImage: Images.robertPlantLullaby, albumTitle: "Lullaby and The Ceaseless Roar", artistName: "Robert Plant", artistImage: Images.robertPlant, artistDetails: "TBD"),
            Album(albumImage: Images.robertPlantCarryFire, albumTitle: "Carry Fire", artistName: "Robert Plant", artistImage: Images.robertPlant, artistDetails: "TBD"),
            Album(albumImage: Images.vanHalenDifferentTypeOfTruth, albumTitle: "A Different Type of Truth", artistName: "Van Halen", artistImage: Images.vanHalen, artistDetails: "TBD")
        ]
        return albums.sorted(by: { $0.albumTitle < $1.albumTitle })
    }
}
