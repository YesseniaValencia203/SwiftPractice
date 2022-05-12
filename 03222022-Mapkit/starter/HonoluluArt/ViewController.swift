/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import MapKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var mapView: MKMapView!
  // This array holds the Artwork objects from the GeoJSON file to the class.
  private var artworks: [Artwork] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    mapView.centerToLocation(initialLocation)
    
    let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
    let region = MKCoordinateRegion(
      center: oahuCenter.coordinate,
      latitudinalMeters: 50000,
      longitudinalMeters: 60000)
    mapView.setCameraBoundary(
      MKMapView.CameraBoundary(coordinateRegion: region),
      animated: true)
    
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
    mapView.setCameraZoomRange(zoomRange, animated: true)

    
    mapView.delegate = self

    // Show artwork on map
    // Create a new Artwork object and add it as an annotation to the map view
    /*
    let artwork = Artwork(
      title: "King David Kalakaua",
      locationName: "Waikiki Gateway Park",
      discipline: "Sculpture",
      coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
    mapView.addAnnotation(artwork)
    */
    
    /*
    mapView.register(
      ArtworkMarkerView.self,
      forAnnotationViewWithReuseIdentifier:
        MKMapViewDefaultAnnotationViewReuseIdentifier)
    // Here, you register your new class witht he map view's default reuse identifier. For an app with more annotation types, you would register classes with custom identifiers.
    */
    mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    
    loadInitialData()
    mapView.addAnnotations(artworks)
  }
  
  private func loadInitialData() {
    // 1 Read PublicArt.geojson into a Data object
    guard
      let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
      let artworkData = try? Data(contentsOf: fileName)
      else {
        return
    }

    do {
      // 2 You use MKGeoJSONDecoder to obtain an array of GeoJSON objects but only keep instances of MKGeoJSON feature using compactMap
      let features = try MKGeoJSONDecoder()
        .decode(artworkData)
        .compactMap { $0 as? MKGeoJSONFeature }
      // 3 You transform the MKGeoJSONGeature objects into Artwork objects using its failiable initializer you added and compactMap again.
      let validWorks = features.compactMap(Artwork.init)
      // 4 Append the resulting validWorks to the artworks array
      artworks.append(contentsOf: validWorks)
    } catch {
      // 5 Because MKGeoJSONDecoder's decode(_ :) method can throw an error, you catchit and print error to console.
      print("Unexpected error: \(error).")
    }
  }

}
private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    // location is the center point
    // regionRadius has a default of 1000 meters.
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    
    // setRegion(_:animated:) tells MKMapView to display the region represented by MKCoordinateRegion
    // the map view automatically transitions the current view to the desired region with zoom animation.
    setRegion(coordinateRegion, animated: true)
    
  }
}
// Delegate's job is to return an instance of MKAnnotationVIew to present as a visual indicator for the annotation.
extension ViewController: MKMapViewDelegate {
  
  /*
  // 1 map(_:viewFor:) gets called for every annotation you add to the mpa. like tableView(_:cellForRowAt:)
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    // 2 Your app might use other annotation, like user location, so check that this annotation is an Artwork object. If not, return nil so map view uses default annotation view
    guard let annotation = annotation as? Artwork else {
      return nil
    }
    // 3 Create each view as an MKMarketAnnotationView.
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    // 4 A map view reuses annotation views are no longer visible so you check if a reusable annotation view is available before creating a new one.
    if let dequeuedView = mapView.dequeueReusableAnnotationView(
      withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5  Here, you create a new MKMarkerAnnotationView object if
      view = MKMarkerAnnotationView(
        annotation: annotation,
        reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
  
  */
  
  
  
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    // grab the Artwork object this tap refers to, then launch Maps by creating an associated MKMapItem and calling openInMaps(launchOptions:) on the map item.
    guard let artwork = view.annotation as? Artwork else {
      return
    }

    let launchOptions = [
      MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ]
    // You're passing a dictionary into this method, allowing you to specify a few different options.
    // Here, DirectionsModeKey is set to Driving , causing Maps to show driving directions from the user's current locations to this locatin.
    artwork.mapItem?.openInMaps(launchOptions: launchOptions)
  }

}

