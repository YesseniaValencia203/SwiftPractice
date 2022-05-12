//
//  ViewController.swift
//  AVSamp
//
//  Created by Consultant on 3/23/22.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playTapped(_ sender: Any) {
        if let player = player, player.isPlaying {
            player.stop()
            playButton.setTitle("PLAY", for: .normal)
        } else {
            playButton.setTitle("STOP", for: .normal)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                let urlString = Bundle.main.path(forResource: "Starman", ofType: "mp3")
                guard let urlString = urlString else { return }
                // want to make sure we have proper path to our resource
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else { return }

                player.play()
                
            } catch {
                print("error")
            }
        }
    }
    
}

