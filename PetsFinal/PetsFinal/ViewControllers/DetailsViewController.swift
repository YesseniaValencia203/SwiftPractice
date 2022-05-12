import UIKit

class DetailsViewController: UIViewController {
    
    var pet: AnimalResponse?
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petSpeciesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        petNameLabel.text = pet?.name?.capitalized
        petGenderLabel.text = pet?.gender?.capitalized
        petSpeciesLabel.text = pet?.species?.capitalized
        petAgeLabel.text = pet?.age?.capitalized
        
        if let image = pet?.photos.first?.small {
            petImageView.getImage(from: URL(string: (image))!)
        }
    
        

        // Do any additional setup after loading the view.
    }


}
