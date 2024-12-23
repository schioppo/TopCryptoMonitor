//
//  ErrorView.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import SwiftUI

struct ErrorView: View {
    var action: () -> Void
    var errorMessage: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                action()
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
    }
}
