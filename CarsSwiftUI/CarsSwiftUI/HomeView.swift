//
//  ContentView.swift
//  CarsSwiftUI
//
//  Created by Consultant on 4/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModelImpl()
    
    
    
    
    var body: some View {
        let cars: [Car] = viewModel.getCars()
        NavigationView {
            List(cars) { car in
                CarCell(car: car)
            }
            .navigationBarTitle("Top Cars of the Decade", displayMode: .inline)
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}

struct CarCell: View {
    let car: Car
    var body: some View {
        NavigationLink(destination:
                        DetailsView(description: car.description, image: car.image, name: car.title)) {
            VStack(alignment: .leading) {
                HStack {
                    car.image
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("\(car.title)")
                    
                }
            }
        }
    }
}
