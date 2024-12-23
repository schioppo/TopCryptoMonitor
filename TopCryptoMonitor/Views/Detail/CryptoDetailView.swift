//
//  CryptoDetailView.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 22/12/24.
//

import Foundation
import SwiftUI
import Charts

struct CryptoDetailView: View {
    @ObservedObject var viewModel: CryptoDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    
                    Spacer()
                    Loader()
                    Spacer()
                    
                } else if let error = viewModel.errorMessage {
                    
                    Spacer()
                    ErrorView(action: viewModel.retry, errorMessage: error)
                    Spacer()
                    
                } else {
                    
                    VStack(alignment: .leading) {
                        
                        Text(viewModel.crypto?.description ?? "")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        if let url = URL(string: viewModel.crypto?.website ?? "") {
                            Link(LocalizableStrings.visitWebsite, destination: url)
                                .padding(.bottom)
                        }
                        
                        Text(LocalizableStrings.lastWeekPrices)
                            .font(.headline)
                            .padding(.bottom)
                        
                        if let crypto = viewModel.crypto {
                            
                            BaseCryptoSingleLineChart(values: crypto.lastWeekPriceValues)
                            
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

// MARK: - BaseCryptoSingleLineChart
struct BaseCryptoSingleLineChart: View {
    var values: [Double]
    
    var body: some View {
        Chart {
            ForEach(values.indices, id: \.self) { index in
                LineMark(
                    x: .value("Time", index),
                    y: .value("Price", values[index])
                )
                .foregroundStyle(.green)
            }
        }
        .frame(height: 300)
        .padding()
        .chartXAxis { AxisMarks(values: ["Last week"]) }
        .cardWithShadow()
    }
}

