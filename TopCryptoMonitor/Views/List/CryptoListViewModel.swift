//
//  CryptoListViewModel.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import Combine

//MARK: - CryptoListViewModelNavigationDelegate
protocol CryptoListViewModelNavigationDelegate {
    func goToDetail(of crypto: Crypto)
}

//MARK: - CryptoListViewModel
class CryptoListViewModel: ObservableObject {
    @Published var topCryptos: [Crypto] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let navigationDelegate: CryptoListViewModelNavigationDelegate
    private let apiProvider: ApiProvider

    init(navigationDelegate: CryptoListViewModelNavigationDelegate,
         apiProvider: ApiProvider) {
        self.navigationDelegate = navigationDelegate
        self.apiProvider = apiProvider
    }

    func getCryptos() {
        
        Task { [weak self] in
            guard let self else { return }
            
            await MainActor.run { 
                self.errorMessage = nil
                self.isLoading = true
            }
            
            do {
                let allCryptos = try await apiProvider.getCryptoList()
                
                await MainActor.run { 
                    self.topCryptos = allCryptos
                        .map { Crypto(id: $0.id, name: $0.name, image: $0.image, price: $0.currentPrice) }
                }
                
            } catch {
                guard let error = error as? NetworkError else { return }
                print(error.errorDescription)
                await MainActor.run { self.errorMessage = CryptoAPIError.getCryptoList.errorDescription }
            }
            
            await MainActor.run { self.isLoading = false }
        }
    }
    
    func retry() { getCryptos() }

    func didTapCrypto(_ crypto: Crypto) {
        navigationDelegate.goToDetail(of: crypto)
    }
    
}


