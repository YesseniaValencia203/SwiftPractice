//
//  ResultStates.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation

enum ResultStates {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
