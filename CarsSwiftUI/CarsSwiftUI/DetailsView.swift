//
//  DetailsView.swift
//  CarsSwiftUI
//
//  Created by Consultant on 4/4/22.
//

import SwiftUI

struct DetailsView: View {
    var description: String
    var image: Image
    var name: String
    
    init(description: String, image: Image, name: String) {
        self.description = description
        self.image = image
        self.name = name 
    }
    
    var body: some View {
        image
            .resizable()
            .frame(width: 160, height: 160, alignment: .center)
        Text(description)
        .navigationTitle(name)
        
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(description: "Description", image: Image(systemName: "image"), name: "")
    }
}

