//
//  AlbumViewController.swift
//  TopAlbums
//
//  Created by Consultant on 3/8/22.
//

import UIKit

class AlbumViewController: UIViewController {
    var albums: [Album] = []
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        albums = fetchData()
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 70

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            let cell = albums[(tableview.indexPathForSelectedRow?.row)!]
            destination.album = cell 
            
        }
    }

}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumTableViewCell
        cell.textLabel?.text = albums[indexPath.row].albumTitle
        cell.detailTextLabel?.text = albums[indexPath.row].artistName
        cell.albumImageView?.image = albums[indexPath.row].albumImage
        
        return cell
    }

}
extension AlbumViewController {
    func fetchData() -> [Album] {
        let albums = [
            Album(albumImage: Images.davidBowieBlackstar, albumTitle: "Blackstar", artistName: "David Bowie", artistImage: Images.davidBowie, artistDetails: "Two days after its release, Bowie died of liver cancer; his illness had not been revealed to the public until then. Visconti described the album as Bowie's intended swan song and a \"parting gift\" for his fans before his death."),
            Album(albumImage: Images.davidBowieTheNextDay, albumTitle: "The Next Day", artistName: "David Bowie", artistImage: Images.davidBowie, artistDetails: "A leading figure in the music industry, Bowie is regarded as one of the most influential musicians of the 20th century. He was acclaimed by critics and musicians, particularly for his innovative work during the 1970s. His career was marked by reinvention and visual presentation, and his music and stagecraft had a significant impact on popular music."),
            Album(albumImage: Images.rollingStonesBlueAndLonesome, albumTitle: "Blue and Lonesome", artistName: "The Rolling Stones", artistImage: Images.rollingStones, artistDetails: "The Rolling Stones are an English rock band formed in London in 1962. Active for six decades, they are one of the most popular and enduring bands of the rock era. In the early 1960s, the Rolling Stones pioneered the gritty, heavier-driven sound that came to define hard rock."),
            Album(albumImage: Images.paulSimonSoBeautifulSoWhat, albumTitle: "So Beautiful Or So What", artistName: "Paul Simon", artistImage: Images.paulSimon, artistDetails: "Paul Frederic Simon (born October 13, 1941) is an American musician, singer, songwriter, and actor whose career has spanned six decades. He is one of the most acclaimed songwriters in popular music."),
            Album(albumImage: Images.jackWhiteBlunderbuss, albumTitle: "Blunderbuss", artistName: "Jack White", artistImage: Images.jackWhite, artistDetails: "John Anthony White (né Gillis; born July 9, 1975) is an American singer, songwriter, multi-instrumentalist and producer. He is best known as the lead singer and guitarist of the duo the White Stripes. White has enjoyed consistent critical and popular success and is widely credited as one of the key artists in the garage rock revival of the 2000s"),
            Album(albumImage: Images.blackKeysBrothers, albumTitle: "Brothers", artistName: "The Black Keys", artistImage: Images.blackKeys, artistDetails: "The Black Keys are an American rock band formed in Akron, Ohio, in 2001. The group consists of Dan Auerbach (guitar, vocals) and Patrick Carney (drums). The duo began as an independent act, recording music in basements and self-producing their records, before they eventually emerged as one of the most popular garage rock artists during a second wave of the genre's revival in the 2000s."),
            Album(albumImage: Images.iggyPopPostPopDepression, albumTitle: "Post Pop Depression", artistName: "Iggy Pop", artistImage: Images.iggyPop, artistDetails: "James Newell Osterberg Jr. (born April 21, 1947), known professionally as Iggy Pop, is an American musician, singer, and songwriter. Designated the \"Godfather of Punk\" he was the vocalist and lyricist of proto-punk band The Stooges, who were formed in 1967 and have disbanded and reunited many times since"),
            Album(albumImage: Images.robertPlantLullaby, albumTitle: "Lullaby and The Ceaseless Roar", artistName: "Robert Plant", artistImage: Images.robertPlant, artistDetails: "Robert Anthony Plant CBE (born 20 August 1948) is an English singer and songwriter, best known as the lead singer and lyricist of the English rock band Led Zeppelin for all of its existence from 1968 up until 1980, when the band broke up following the death of John Bonham, the band's drummer."),
            Album(albumImage: Images.robertPlantCarryFire, albumTitle: "Carry Fire", artistName: "Robert Plant", artistImage: Images.robertPlant, artistDetails: "Robert Anthony Plant CBE (born 20 August 1948) is an English singer and songwriter, best known as the lead singer and lyricist of the English rock band Led Zeppelin for all of its existence from 1968 up until 1980, when the band broke up following the death of John Bonham, the band's drummer."),
            Album(albumImage: Images.vanHalenDifferentTypeOfTruth, albumTitle: "A Different Type of Truth", artistName: "Van Halen", artistImage: Images.vanHalen, artistDetails: "Credited with \"restoring hard rock to the forefront of the music scene\",Van Halen was known for its energetic live shows and for the virtuosic talent of its lead guitarist, Eddie Van Halen.The band was inducted into the Rock and Roll Hall of Fame in 2007.")
        ]
        return albums.sorted(by: { $0.albumTitle < $1.albumTitle })
    }
}
