//
//  GetCryptoDetailAPI.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 22/12/24.
//

import Foundation

struct GetCryptoDetailAPI: API {
    
    var path: String
    var method: HTTPMethod = .get
    var headers: [String : String]?
    var queryParameters: [String : String]? = [
        "localization": "false",
        "tickers": "false",
        "market_data": "true",
        "community_data": "false",
        "developer_data": "false",
        "sparkline": "true"
    ]
    var bodyRequest: Data?
    
    init(id: String) {
        self.path = "/coins/\(id)"
    }
    
    typealias Output = CryptoDetailDTO
    
    struct CryptoDetailDTO: Codable {
        let name: String
        let descriptionHtml: [String: String]
        let links: CryptoLinkDTO
        let marketData: MarketDataDTO
        
        enum CodingKeys: String, CodingKey {
            case name
            case descriptionHtml = "description"
            case links
            case marketData = "market_data"
        }
    }
    
    struct CryptoLinkDTO: Codable {
        let homepage: [String]
    }
    
    struct MarketDataDTO: Codable {
        let sparkline7d: SparkLine
        
        enum CodingKeys: String, CodingKey {
            case sparkline7d = "sparkline_7d"
        }
    }
    
    struct SparkLine: Codable {
        let prices: [Double]
        
        enum CodingKeys: String, CodingKey {
            case prices = "price"
        }
    }
}
