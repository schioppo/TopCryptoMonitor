//
//  Loader.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import SwiftUI

struct Loader: View {
    
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .padding()
    }
}
