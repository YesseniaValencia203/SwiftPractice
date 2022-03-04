import Foundation
import UIKit

extension UIImageView {
    func getImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { print("Bad response")
                return }
            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { print("mime-type")
                return }
            guard let data = data, error == nil else { print("data")
                return }
            guard let image = UIImage(data: data) else { print("UIImage")
                return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            
        }
        task.resume()
    }
}
