/*
  Localizationable.swift
  chingari

  Created by Setu Kanani on 18/06/21.
  Copyright © 2020 Nikola Milic. All rights reserved.
*/

import Foundation
import Localize_Swift

enum Localizationable {
    
    static func languages() -> [Language] {
        LanguageType.languageTypes.map({ Language(type: $0) })
    }
    
    static func internationalLanguages() -> [Language] {
        LanguageType.internationalLanguageTypes.map({ Language(type: $0) })
    }
    
    static func getCurrentLanguage() -> String {
        guard let settingLanguage = Locale.current.localizedString(forLanguageCode: Locale.current.identifier) else {
            return Language(type: .english).title.lowercased()
        }
        return settingLanguage.lowercased()
    }
    
    static func getCurrentLanguageId() -> String {
        guard  let settingLanguage = Locale.current.languageCode else {
            return Language(type: .english).id
        }
        return settingLanguage
    }
    
    enum Global: String, LocalizableDelegate {
        case error = "Global.error"
        case insertText = "Global.InsertText"
        case result = "Global.Result"
        case calculate = "Global.Calculate"
        case info = "Global.Info"
        case appInfoText = "Global.AppInfoText"
    }
    
    enum Numerology: String, LocalizableDelegate {
        case numerologyDescription0 = "Numerology.Description_0"
        case numerologyDescription1 = "Numerology.Description_1"
        case numerologyDescription2 = "Numerology.Description_2"
        case numerologyDescription3 = "Numerology.Description_3"
        case numerologyDescription4 = "Numerology.Description_4"
        case numerologyDescription5 = "Numerology.Description_5"
        case numerologyDescription6 = "Numerology.Description_6"
        case numerologyDescription7 = "Numerology.Description_7"
        case numerologyDescription8 = "Numerology.Description_8"
        case numerologyDescription9 = "Numerology.Description_9"
        case incorrectAlgorythm = "Numerology.IncorrectAlgorythm"
    }
}
