import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    var pokemon: PokemonEntity? {
        didSet {
            setupCell()
        }
    }
    private func setupCell() {
        guard let pokemon = pokemon else { return }
        let url = URL(string: (pokemon.url)!)
        URLSession.shared.getRequest(url: url, decoding: PokemonProfile.self) { [weak self] result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    guard let pokemonName = profile.name else { return }
                    guard let pokemonTypes = profile.pokemonTypes else { return }
                    guard let stringURL = profile.sprites?.front_default else { return }
                    var typeString = "Type: "
                    for pokeType in pokemonTypes {
                        typeString += "\((pokeType.type?.name)!.capitalized) "
                    }
                    self?.pokemonTypesLabel.text = typeString
                    self?.pokemonNameLabel.text = pokemonName.capitalized
                    
                    self?.pokemonImageView.getImage(from: stringURL)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
