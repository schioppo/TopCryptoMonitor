//
//  GetCryptoListAPI.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import UIKit

struct GetCryptoListAPI: API {

    var path: String = "/coins/markets"
    var method: HTTPMethod = .get
    var headers: [String : String]?
    var queryParameters: [String : String]? = [
        "vs_currency": "eur",
        "order": "market_cap_desc",
        "per_page": "10"
    ]
    var bodyRequest: Data?
    
    typealias Output = CryptoDTO
    
    struct CryptoDTO: Codable {
        var id: String
        var name: String
        var currentPrice: Double
        var image: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case currentPrice = "current_price"
            case image
        }
    }
    
}
