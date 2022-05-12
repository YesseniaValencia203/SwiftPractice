//
//  ArticleView.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import SwiftUI
import UIKit
import URLImage

struct ArticleView: View {
    
    let article: Article
    var body: some View {
        HStack {
            if let image = article.image, let url = URL(string: image) {
                URLImage(url, identifier: article.id.uuidString) { error, retry in
                    PlaceHolderImageView()
                },
            content: {image in
                image.resizeable()
                    .aspectRation(contentMode: .)
                
            }
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
