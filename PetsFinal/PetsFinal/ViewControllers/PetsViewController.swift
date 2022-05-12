import UIKit


class PetsViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var animals: [AnimalResponse] = [AnimalResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        
        guard let jsonData = loadLocalFile(forFileName: "response") else {
            print("Error Here")
            return
        }
        self.parseAnimals(jsonData: jsonData)
        
        tableview.reloadData()
        // Do any additional setup after loading the view.
        
    }
    private func loadLocalFile(forFileName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                print(jsonData)
                return jsonData
            }
        } catch {
            print("ERROR")
        }
        return nil
    }
    private func parseAnimals(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(AnimalsResponse.self, from: jsonData)
            DispatchQueue.main.async { [weak self] in
                self?.animals = decodedData.animals!
                self?.tableview.reloadData()
            }
               // animals = decodedData.animals!
            for animal in decodedData.animals! {
                print(animal.name!)
                print(animal.species!)
                print(animal.age!)
                print(animal.id!)
                animals.append(animal)
            }
            //print(decodedData.animals)
        } catch {
            print("decode Error")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pet" {
            if let detailsVC = segue.destination as? DetailsViewController {
                let pet = animals[(tableview.indexPathForSelectedRow?.row)!]
                detailsVC.pet = pet 
                detailsVC.petAgeLabel?.text = pet.age?.capitalized
                detailsVC.petNameLabel?.text = pet.name?.capitalized
                detailsVC.navigationItem.title = pet.name?.capitalized
                detailsVC.petGenderLabel?.text = pet.gender?.capitalized
                detailsVC.petSpeciesLabel?.text = pet.species?.capitalized
                if !pet.photos.isEmpty {
                    detailsVC.petImageView?.getImage(from: URL(string: pet.photos.first!.small)!)
                }
                
            }
        }
    }
}

extension PetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetsTableViewCell
        
        let animal = animals[indexPath.row]
        cell.petsNameLabel.text = animal.name?.capitalized
        cell.petsBreedLabel.text = animal.species?.capitalized
        
        if !animal.photos.isEmpty {
            cell.petsImageView.getImage(from: URL(string: animal.photos.first!.small)! )
        }
        cell.petsImageView?.contentMode = .scaleAspectFit
        
        cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cell.favoriteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        cell.accessoryView = cell.favoriteButton
        cell.configureFavorites()
        return cell
    }
}
