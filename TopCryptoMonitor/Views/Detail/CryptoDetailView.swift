//
//  CryptoDetailView.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 22/12/24.
//

import Foundation
import SwiftUI
import Charts

struct CryptoDetail {
    var name: String
    var description: String
    var website: String
    var lastWeekPriceValues: [Double]
}

struct CryptoDetailView: View {
    @ObservedObject var viewModel: CryptoDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                } else {
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.crypto?.name ?? "")
                            .font(.headline)
                            .padding(.bottom)
                        
                        Text(viewModel.crypto?.description ?? "")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        if let url = URL(string: viewModel.crypto?.website ?? "") {
                            Link("Visit website", destination: url)
                                .padding(.bottom)
                        }
                        
                        Text("Last week prices:")
                            .font(.headline)
                            .padding(.bottom)
                        
                        if let crypto = viewModel.crypto {
                            Chart {
                                ForEach(crypto.lastWeekPriceValues.indices, id: \.self) { index in
                                    LineMark(
                                        x: .value("Time", index),
                                        y: .value("Price", crypto.lastWeekPriceValues[index])
                                    )
                                }
                            }
                            .frame(height: 300)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                            )
                            .chartXAxis {
                                AxisMarks(values: ["Last week"])
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.getCryptoDetail()
            }
            .padding()
        }
    }
}
