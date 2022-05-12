//
//  ViewModel.swift
//  CarsSwiftUI
//
//  Created by Consultant on 4/4/22.
//

import Foundation

protocol ViewModel {
    func getCars() -> [Car]
}

class ViewModelImpl: ObservableObject, ViewModel {
    private(set) var cars = [Car]()
    
    func getCars() -> [Car] {
        let cars = [
            Car(image: Images.firstCar, title: "Range Rover", description: "The current, fourth-generation Range Rover is as revolutionary as any in the car’s history, with an aluminium monocoque chassis and an unashamedly luxurious agenda."),
            Car(image: Images.secondCar, title: "Mercedes-Benz S-Class", description: "When Mercedes-Benz sets out to make a new S-Class, the brief is to make the best car in the world; simple as that. It has done on every single occasion that this defining ‘big Benz’ has been redesigned over the decades, and the last time that happened in 2020, in a more challenging and fast-changing luxury car market than the car has ever faced, Stuttgart very likely did just the same."),
            Car(image: Images.thirdCar, title: "Audi E-tron Quattro", description: "This car combines four-wheel drive and a commanding outright performance level with SUV-typical space, convenience and usability, and also with Audi brand desirability. But what really makes it stand out is how superbly hushed, comfortable and refined it is."),
            Car(image: Images.fourthCar, title: "Audi A8", description: "The latest Audi A8 features some of the most advanced chassis, powertrain and in-car technology in the luxury class including, when it’s finally switched on, what promises to be the greatest capability for autonomous driving of any production car in the world. The car represents Audi doing classic ‘vorsprung durch technik’ in a properly committed way."),
            Car(image: Images.fifthCar, title: "Mercedes CLS", description: "The CLS doesn’t quite offer limo-like rear seat space, but in every other respect it is a luxury car worth seriously considering."),
            Car(image: Images.sixthCar, title: "BMW 7 Series", description: "An unexpectedly appealing driver’s car, then, even if it falls behind its very best rivals in ways more core to the mission and identity of the luxury car."),
            Car(image: Images.seventhCar, title: "BMW X7", description: "On the road, the X7 handles its size and bulk well, feeling surprisingly precise and athletic when cornering. Even the car’s diesel engine is smooth and refined, developing enough torque to move the car along easily, while its ride is comfortable without running out of control. The car manages its mass better than big luxury SUV rivals, and feels more intuitive to drive."),
            Car(image: Images.eightCar, title: "Audi Q8", description: "Comfort and refinement are first class. The driving experience is light-feeling and filtered, with stable and secure handling being delivered like it might be on a less advanced four-wheel drive estate car. And the car’s engine range is wide. You can have six-cylinder petrol or diesel power; there’s a choice of two emissions-saving plug-in hybrid petrol engines, one with as much as 457bhp; and then there are the SQ8 and RS Q8 performance models, which allow you to mix as much urgency into the Q8’s driving experience as anyone could want."),
            Car(image: Images.ninthCar, title: "Lexus LS", description: "The car's had a major styling overhaul, and the interior feels both modern and luxurious in a likably unconventional way. There are four trim levels, the top one coming with plenty of equipment and, spec-depending, also a rare kind of material richness that few cars in the world can match."),
            Car(image: Images.tenthCar, title: "Maserati Quattroporte", description: "Maserati has never traded on the built-in quality or digital technological allure of the German luxury car power, and it’s no surprise to find a bit of a gulf between the apparent sophistication of the Quattroporte’s interior and that of some of its opponents. Modena counters with smooth-feeling leathers and some unusual and appealing material treatments, though.")
        ]
        return cars
    }
}
