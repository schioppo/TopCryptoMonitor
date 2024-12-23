//
//  LocalizedString.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import Foundation

enum Language: String {
    case english = "en"
    case italian = "it"
    
    static var currentLanguage: String {
        Locale.current.language.languageCode?.identifier ?? Self.english.rawValue
    }
}

@propertyWrapper
struct LocalizedString {
    private var localizedValues: [String: String]
    
    var wrappedValue: String { localizedValues[Language.currentLanguage] ?? "-" }
    
    init(values: [String: String]) {
        self.localizedValues = values
    }
}
