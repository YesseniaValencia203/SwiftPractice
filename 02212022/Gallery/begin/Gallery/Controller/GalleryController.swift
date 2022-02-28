/// Copyright (c) 2019 Razeware LLC
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

class GalleryController: UIViewController {
  lazy var cardView1: CardView = {
    let cardView = CardView(with: .skeleton)
    // translatesAutoresizingMaskIntoConstraints = false because you want Auto Layout to dynamically calculate the views' positions and sizing according to their constraints
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView2: CardView = {
    let cardView = CardView(with: .owl)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView3: CardView = {
    let cardView = CardView(with: .panda)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView4: CardView = {
    let cardView = CardView(with: .monkey)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  // calls two pre-defined methods to add cards to the view and set up card constraints
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
    view.backgroundColor = .white
  }
  
  // MARK: - Setting Views
  private func setupViews() {
    view.addSubviews(cardView1, cardView2, cardView3, cardView4)
    
  }
  
  // MARK: - Setting Constraints
  private func setupConstraints() {
    /*
    // added call to NSLayoutConstraint to activate an array of constraints which contain
    NSLayoutConstraint.activate([
      // centerX and centerY constraint anchors to make sure the card is laid out in the exact horizontal and vertical center of the view
      cardView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cardView1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      // width and height constraint anchors to fix width/height of the card
      cardView1.widthAnchor.constraint(equalToConstant: 120),
      cardView1.heightAnchor.constraint(equalToConstant: 200)
    
    ])
     */
    /*
     DOESN'T ACCOUNT FOR LANDSCAPE VIEW
     
    let safeArea = view.safeAreaLayoutGuide
    let viewFrame = view.bounds
    //card 1
    NSLayoutConstraint.activate([
      cardView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      cardView1.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView1.widthAnchor.constraint(equalToConstant: viewFrame.width/2),
      cardView1.heightAnchor.constraint(equalToConstant: viewFrame.height/2)
    ])
        
    //card 2
    NSLayoutConstraint.activate([
      cardView2.leadingAnchor.constraint(equalTo: cardView1.trailingAnchor),
      cardView2.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView2.widthAnchor.constraint(equalToConstant: viewFrame.width/2),
      cardView2.heightAnchor.constraint(equalToConstant: viewFrame.height/2),
      cardView2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
        
    //card 3
    NSLayoutConstraint.activate([
      cardView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      cardView3.topAnchor.constraint(equalTo: cardView1.bottomAnchor),
      cardView3.widthAnchor.constraint(equalToConstant: viewFrame.width/2),
      cardView3.heightAnchor.constraint(equalToConstant: viewFrame.height/2),
      cardView3.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    ])
        
    //card 4
    NSLayoutConstraint.activate([
      cardView4.leadingAnchor.constraint(equalTo: cardView3.trailingAnchor),
      cardView4.topAnchor.constraint(equalTo: cardView2.bottomAnchor),
      cardView4.widthAnchor.constraint(equalToConstant: viewFrame.width/2),
      cardView4.heightAnchor.constraint(equalToConstant: viewFrame.height/2),
      cardView4.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    ])
    */
    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      cardView1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      cardView1.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView1.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView1.heightAnchor.constraint(equalTo: safeArea.heightAnchor,
                                        multiplier: 0.5),

      cardView2.leadingAnchor.constraint(equalTo: cardView1.trailingAnchor),
      cardView2.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView2.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView2.heightAnchor.constraint(equalTo: safeArea.heightAnchor,
                                        multiplier: 0.5),
      cardView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

      cardView3.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      cardView3.topAnchor.constraint(equalTo: cardView1.bottomAnchor),
      cardView3.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView3.heightAnchor.constraint(equalTo: safeArea.heightAnchor,
                                        multiplier: 0.5),
      cardView3.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

      cardView4.leadingAnchor.constraint(equalTo: cardView3.trailingAnchor),
      cardView4.topAnchor.constraint(equalTo: cardView2.bottomAnchor),
      cardView4.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView4.heightAnchor.constraint(equalTo: safeArea.heightAnchor,
                                        multiplier: 0.5),
      cardView4.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
    ])

  }
}
