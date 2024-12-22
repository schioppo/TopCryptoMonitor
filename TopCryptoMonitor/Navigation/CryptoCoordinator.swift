//
//  CryptoCoordinator.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import UIKit
import SwiftUI

//MARK: - CryptoCoordinator
final class CryptoCoordinator: NSObject {
    
    private var window: UIWindow?
    var navigationController: UINavigationController?
    
    var apiProvider: ApiProvider
    
    init(apiProvider: ApiProvider = ApiProviderImplementation()) {
        self.apiProvider = apiProvider
    }
    
    func start(from window: UIWindow?) {
        guard let window else { return }
        
        self.window = window
        
        let cryptoListViewModel = CryptoListViewModel(
            navigationDelegate: self,
            apiProvider: apiProvider)
        let rootController = UIHostingController(
            rootView: CryptoListView(viewModel: cryptoListViewModel))
        
        navigationController = UINavigationController(rootViewController: rootController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

//MARK: - CryptoListViewModelNavigationDelegate
extension CryptoCoordinator: CryptoListViewModelNavigationDelegate {
    
    func goToDetail(of crypto: Crypto) {
        
        let cryptoDetailViewModel = CryptoDetailViewModel(apiProvider: apiProvider, cryptoId: crypto.id)
        let cryptoDetailController = UIHostingController(
            rootView: CryptoDetailView(viewModel: cryptoDetailViewModel))
        
        navigationController?.pushViewController(cryptoDetailController, animated: true)
    }
    
}

