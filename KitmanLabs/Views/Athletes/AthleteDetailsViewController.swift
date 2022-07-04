//
//  AthleteDetailsViewController.swift
//  KitmanLabs
//

import UIKit

class AthleteDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var detailsTitle: UIView!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var playerNameStackView: UIStackView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var usernameStackView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var squadStackView: UIStackView!
    @IBOutlet weak var squadLabel: UILabel!
    
    var playerDetails: PlayerDetails? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let playerDetails = playerDetails {
            playerNameLabel.text = playerDetails.playerName
            usernameLabel.text = playerDetails.username
            squadLabel.text = playerDetails.squad
            imageView.downloadImage(from: playerDetails.url)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
