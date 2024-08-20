//
//  AppLanguage.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/8/24.
//

import Foundation

enum AppLanguage: String {
    case russian = "ru"
    
    static let shared = AppLanguage()
    
    private init?() {
        guard let code = Locale.current.language.languageCode?.identifier else { return nil }
        switch code {
        case "ru":
            self = .russian
        default: return nil
        }
    }
}
