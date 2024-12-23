//
//  CryptoDetailViewModel.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 22/12/24.
//

import Combine
import Foundation

//MARK: - CryptoListViewModel
class CryptoDetailViewModel: ObservableObject {
    @Published var crypto: CryptoDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiProvider: ApiProvider
    private let cryptoId: String

    init(apiProvider: ApiProvider, cryptoId: String) {
        self.apiProvider = apiProvider
        self.cryptoId = cryptoId
    }

    func getCryptoDetail() {
        Task { [weak self] in
            guard let self else { return }
            
            await MainActor.run {
                self.errorMessage = nil
                self.isLoading = true
            }
            
            do {
                let cryptoDetail = try await apiProvider.getCryptoDetail(of: cryptoId)
                
                await MainActor.run {
                    self.crypto =
                        CryptoDetail(name: cryptoDetail.name,
                                     description: cryptoDetail.descriptionHtml.htmlToString(),
                                     website: cryptoDetail.links.homepage.first ?? "",
                                     lastWeekPriceValues: cryptoDetail.marketData.sparkline7d.prices)
                }
                
            } catch {
                guard let error = error as? NetworkError else { return }
                print(error.errorDescription)
                await MainActor.run { self.errorMessage = CryptoAPIError.getCryptoDetail.errorDescription }
            }
            
            await MainActor.run { self.isLoading = false }
        }
    }
    
    func retry() { getCryptoDetail() }
    
}
