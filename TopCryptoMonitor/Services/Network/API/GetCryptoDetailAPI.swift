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
        "localization": "true",
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
    
    struct CryptoDetailDTO: Decodable {
        @LocalizedString var name: String
        @LocalizedString var descriptionHtml: String
        let links: CryptoLinkDTO
        let marketData: MarketDataDTO
        
        enum CodingKeys: String, CodingKey {
            case name = "localization"
            case descriptionHtml = "description"
            case links
            case marketData = "market_data"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let names = try container.decode([String: String].self, forKey: .name)
            self._name = LocalizedString(values: names)
            let descriptions = try container.decode([String: String].self, forKey: .descriptionHtml)
            self._descriptionHtml = LocalizedString(values: descriptions)
            self.links = try container.decode(CryptoLinkDTO.self, forKey: .links)
            self.marketData = try container.decode(MarketDataDTO.self, forKey: .marketData)
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
