//
//  ViewController.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import SwiftUI

// MARK: - CryptoListView
struct CryptoListView: View {
    @ObservedObject var viewModel: CryptoListViewModel
    
    var body: some View {
        VStack {
            
            Text(LocalizableStrings.homepageTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            if viewModel.isLoading {
                
                Spacer()
                Loader()
                Spacer()
                
            } else if let error = viewModel.errorMessage {
                
                Spacer()
                ErrorView(action: viewModel.retry, errorMessage: error)
                Spacer()
                
            } else {
                
                ScrollView {
                    LazyVStack(spacing: 5) {
                        ForEach(viewModel.topCryptos) { crypto in
                            CryptoRowView(crypto: crypto)
                                .cardWithShadow(shadowOpacity: 0.2, shadowY: 0)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 8)
                                .onTapGesture { viewModel.didTapCrypto(crypto) }
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .onAppear { 
            guard viewModel.topCryptos.isEmpty else { return }
            viewModel.getCryptos()
        }
    }
}

// MARK: - CryptoRowView
struct CryptoRowView: View {
    let crypto: Crypto
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: crypto.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(crypto.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("\(crypto.price, specifier: "%.2f") €")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
        }
        .padding()
    }
}
