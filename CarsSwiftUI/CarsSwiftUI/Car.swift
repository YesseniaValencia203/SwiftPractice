import Foundation
import UIKit
import SwiftUI

class Car: ObservableObject, Identifiable {
    var image: Image
    var title: String
    var description: String
    
    init(image: Image, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}



struct Images {
    static let first = UIImage(named: "1_rangerover_tracking.jpeg")!
    static let firstCar = Image(uiImage: first)
    static let second = UIImage(named: "2-mercedes-s-class-s400d.jpeg")!
    static let secondCar = Image(uiImage: second)
    static let third = UIImage(named: "3-audi-e-tron-s.jpeg")!
    static let thirdCar = Image(uiImage: third)
    static let fourth = UIImage(named: "4-audia8tracking.jpeg")!
    static let fourthCar = Image(uiImage: fourth)
    static let fifth = UIImage(named: "5-merc_cls.jpeg")!
    static let fifthCar = Image(uiImage: fifth)
    static let sixth = UIImage(named: "6-bmw-7-series-750li.jpeg")!
    static let sixthCar = Image(uiImage: sixth)
    static let seventh = UIImage(named: "7-bmw-x7.jpeg")!
    static let seventhCar = Image(uiImage: seventh)
    static let eight = UIImage(named: "8-audi_q8_0.jpeg")!
    static let eightCar = Image(uiImage: eight)
    static let ninth = UIImage(named: "9-lexus-ls500h.jpeg")!
    static let ninthCar = Image(uiImage: ninth)
    static let tenth = UIImage(named: "10-maserati-quattroport.jpeg")!
    static let tenthCar = Image(uiImage: tenth )
}

