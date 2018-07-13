//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Pei Qin on 2018/7/12.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum MGType: String { //MG = Makestagram
        case main
        case login
        var filename: String {
            return rawValue.capitalized
        }//computed variable
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initializeViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't initialize initial view controller for \(type.filename) storyboard.")
        }
        return initialViewController
    }
}
