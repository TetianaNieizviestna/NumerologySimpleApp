//
//  Language.swift
//  chingari
//
//  Created by Chingari MacBook Pro 16 on 01/06/22.
//  Copyright © 2022 Nikola Milic. All rights reserved.
//

import Foundation

enum LanguageType: String, CaseIterable {
    
    case english
    case russian
    case ukrainian
    
    static var languageTypes: [LanguageType] {
        LanguageType.allCases
    }
    
    static var internationalLanguageTypes: [LanguageType] {
        LanguageType.allCases
    }
    
    var title: String {
        rawValue.capitalized
    }
    
    var imageName: String {
        title
    }
    
    var value: String {
        switch self {
        default:
            return title
        }
    }
    
    var id: String {
        switch self {
        case .english: return "en"
        case .russian: return "ru"
        case .ukrainian: return "uk"
        }
    }
    
    var localizedString: String {
        switch self {
        case .english: return "English"
        case .russian: return "Russian"
        case .ukrainian: return "Ukrainian"
        }
    }
}

struct Language: Codable {
    let id: String
    let title: String
    let imageName: String
    let value: String
    let localizedString: String
}

extension Language {
    
    init(type: LanguageType) {
        id = type.id
        title = type.title
        imageName = type.imageName
        value = type.value
        localizedString = type.localizedString
    }
}
