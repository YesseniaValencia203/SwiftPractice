//
//  PopupViewController.swift
//  TopAlbums
//
//  Created by Consultant on 2/27/22.
//

import UIKit

class PopupViewController: UIViewController {
    var popupView: UIView = UIView()
    var artistImage: UIImageView = UIImageView()
    var artistDescription: UILabel = UILabel()
    var artistName: UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.addSubview(popupView)

        // Do any additional setup after loading the view.
    }
    
    func setInformation(_ album: Album) {
        artistImage.image = album.artistImage
        artistName.text = album.artistName
        artistDescription.text = album.artistDetails
    }
    
    func configureView() {
        popupView.layer.cornerRadius = 6
        popupView.addSubview(doneButton)
        popupView.addSubview(artistImage)
        popupView.addSubview(artistName)
        popupView.addSubview(artistDescription)
        configureArtistImage()
        configureArtistDescription()
        configureArtistName()
        setArtistImageConstraints()
        setArtistNameConstraints()
        setArtistDescriptionConstraints()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        
    }
    @objc func dismissView() {
        self.dismiss(animated: false, completion: nil)
    }
    func configureArtistName() {
        artistName.numberOfLines = 0
        artistName.adjustsFontSizeToFitWidth = true
    }
    func configureArtistDescription() {
        artistDescription.numberOfLines = 0
        artistDescription.adjustsFontSizeToFitWidth = true
    }
    func configureArtistImage() {
        artistImage.layer.cornerRadius = 10
        artistImage.clipsToBounds = true
    }
    func setArtistImageConstraints() {
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        artistImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        artistImage.widthAnchor.constraint(equalTo: artistImage.heightAnchor, multiplier: 16/9).isActive = true
        artistImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setArtistNameConstraints() {
        
    }
    func setArtistDescriptionConstraints() {
        artistDescription.translatesAutoresizingMaskIntoConstraints = false
        artistDescription.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artistDescription.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 20).isActive = true
        artistDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        artistDescription.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    
    

    

}
