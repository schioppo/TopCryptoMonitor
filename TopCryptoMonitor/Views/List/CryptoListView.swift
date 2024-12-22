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
            
            Text("Top 10 Cryptos:")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            if viewModel.isLoading {
                
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
                Spacer()
                
            } else if let error = viewModel.errorMessage {
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text(error)
                        .font(.headline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.retry()
                    }) {
                        Text("Retry")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
            } else {
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.topCryptos) { crypto in
                            CryptoRowView(crypto: crypto)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                )
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 2, y: 2)
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
