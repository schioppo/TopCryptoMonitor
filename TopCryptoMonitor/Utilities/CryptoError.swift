//
//  CryptoError.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import Foundation

enum CryptoAPIError {

    case getCryptoList
    case getCryptoDetail
    
    var errorDescription: String {
        switch self {
        case .getCryptoList: return LocalizableStrings.getCryptoListMessageError
        case .getCryptoDetail: return LocalizableStrings.getCryptoDetailMessageError
        }
    }
}
