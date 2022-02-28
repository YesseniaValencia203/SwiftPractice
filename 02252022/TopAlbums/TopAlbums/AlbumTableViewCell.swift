//
//  AlbumTableViewCell.swift
//  TopAlbums
//
//  Created by Consultant on 2/25/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var albumImageView = UIImageView()
    var albumTitle = UILabel()
    var albumArtist = UILabel()
    var artistName : String?
    var artistDescription : String?
    var artistImage : UIImage?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumImageView)
        addSubview(albumTitle)

        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()

    }
    required init?(coder: NSCoder) {
        fatalError("init(Coder) has not been implemented")
    }
    func set(_ album: Album) {
        albumImageView.image = album.albumImage
        albumTitle.text = album.albumTitle
        self.artistName = album.artistName
        self.artistImage = album.artistImage
        self.artistDescription = album.artistDetails
    }
    func configureImageView() {
        albumImageView.layer.cornerRadius = 10
        albumImageView.clipsToBounds = true
    }
    func configureTitleLabel() {
        albumTitle.numberOfLines = 0
        albumTitle.adjustsFontSizeToFitWidth = true
    }

    func setImageConstraints() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor, multiplier: 16/9).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setTitleLabelConstraints() {
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        albumTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumTitle.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 20).isActive = true
        albumTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        albumTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }


}
