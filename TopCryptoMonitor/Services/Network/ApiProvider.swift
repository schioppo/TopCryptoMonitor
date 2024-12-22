//
//  ApiProvider.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import Foundation

//MARK: - ApiProvider
protocol ApiProvider {
    func getCryptoList() async throws -> [GetCryptoListAPI.Output]
    func getCryptoDetail(of id: String) async throws -> GetCryptoDetailAPI.Output
}

//MARK: - ApiProviderImplementation
class ApiProviderImplementation: ApiProvider {
    
    func getCryptoList() async throws -> [GetCryptoListAPI.Output] {
        try await NetworkManager.shared.perform(GetCryptoListAPI())
    }
    
    func getCryptoDetail(of id: String) async throws -> GetCryptoDetailAPI.Output {
        try await NetworkManager.shared.perform(GetCryptoDetailAPI(id: id))
    }
}
