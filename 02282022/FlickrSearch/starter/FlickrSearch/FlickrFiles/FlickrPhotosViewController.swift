import UIKit

final class FlickrPhotosViewController: UICollectionViewController {
  // MARK: - Properties
  private let reuseIdentifier = "FlickrCell"
  private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  // searches is an array that keeps track of all the searches made in the app
  private var searches: [FlickrSearchResults] = []
  // flickr is a reference to the object that searches for you 
  private let flickr = Flickr()
  private let itemsPerRow: CGFloat = 3
}

// MARK: - Private
private extension FlickrPhotosViewController {
  // photo(for:) is a convenience method that gets a specific photo related to an index path in your collection view.
  func photo(for indexPath: IndexPath) -> FlickrPhoto {
    return searches[indexPath.section].searchResults[indexPath.row]
  }
}

// MARK: - Text Field Delegate
extension FlickrPhotosViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard
      let text = textField.text,
      !text.isEmpty
    else { return true }

    // 1 After adding an activity view, you use the Flickr wrapping class to search Flickr asynchronously for photos that match the given search term
    // When the search completes, you call the completion block with the result set of FlickrPhoto objects and any errors
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()

    flickr.searchFlickr(for: text) { searchResults in
      DispatchQueue.main.async {
        activityIndicator.removeFromSuperview()

        switch searchResults {
        case .failure(let error) :
          // 2 Log the errors to the console
          print("Error Searching: \(error)")
        case .success(let results):
          // 3 Log results and add them to the beginning of the searches array
          print("""
            Found \(results.searchResults.count) \
            matching \(results.searchTerm)
            """)
          self.searches.insert(results, at: 0)
          // 4 Refresh the UI to show the new data
          self.collectionView?.reloadData()
        }
      }
    }

    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - UICollectionViewDataSource
// UICollectionViewDataSource returns information about the number of items in the collection view and their views
extension FlickrPhotosViewController {
  // 1 There's one search per section, so the number of sections is the count of searches
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return searches.count
  }

  // 2 The number of items in a section is the count of sectionResults from the relevant FlickrSearch
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return searches[section].searchResults.count
  }

  // 3 Placeholder method to return a blank cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // 1 The cell coming back is now a FlickrPhotoCell
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as! FlickrPhotoCell
    // swiftlint:disable:previous force_cast

    // 2 You need to get the FlickrPhoto representing the photo to display by using the method from earlier
    let flickrPhoto = photo(for: indexPath)
    cell.backgroundColor = .white
    // 3 You populate the image view with the thumbnail
    cell.imageView.image = flickrPhoto.thumbnail

    return cell
  }
}

// MARK: - Collection View Flow Layout Delegate

// UICollectionViewDelegate gets another notification when events happen, such as when a user selects, highlights, or removes a cell
// UICollectionViewDelegateFlowLayout lets you tweak the layout's behavior to configure things like cell spacing, scroll direction, and cell size
extension FlickrPhotosViewController: UICollectionViewDelegateFlowLayout {
  // 1 collectionView(:layout:sizeForItemAt:) tells the layout the size of a given cell
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // 2 Work out the total amount of space taking up by the padding
    // You'll have n+1 evenly-sized spaces where n is the number of items in the tow
    // subtracting the view's width and dividing the number of items in a row gives you the width of each item
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  // 3 collectionView(:layout:insetForSectionAt:) returns the spacing between cells, headers, and footers. A constant stores the value
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }

  // 4 Controls the spacing between each line in the layout
  // You want this spacing to match the padding at the left and right
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
