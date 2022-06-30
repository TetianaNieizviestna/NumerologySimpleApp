/*
  LocalizableDelegate.swift
  chingari

  Created by Setu Kanani on 18/06/21.
  Copyright © 2020 Nikola Milic. All rights reserved.
*/

import Foundation
import Localize_Swift

protocol LocalizableDelegate {
    var rawValue: String { get }    //localize key
    var table: String? { get }
    var localized: String { get }
    func localizedFormat(_ arguments: CVarArg...) -> String
    func localized(identifier: String) -> String
}

extension LocalizableDelegate {
    //returns a localized value by specified key located in the specified table
    var localized: String {
        return rawValue.localized()
    }

    // file name, where to find the localized key
    // by default is the Localizable.string table
    var table: String? {
        return nil
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return rawValue.localizedFormat(arguments)
    }
    
    func localized(identifier: String) -> String {
        return rawValue.localized(using: identifier)
    }
}
