//
//  UIStoryboard.swift
//  NumerologyApp
//
//  Created by Tetiana on 29.01.2021.
//

import UIKit

struct Storyboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }
