//
//  View.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import SwiftUI

public extension View {
    func cardWithShadow(backgroundColor: Color = .white, cornerRadius: CGFloat = 10, shadowRadius: CGFloat = 5, shadowOpacity: Double = 0.5, shadowColor: Color = .gray, shadowY: CGFloat = 5) -> some View {
        self.modifier(CardWithShadowModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowColor: shadowColor, backgroundColor: backgroundColor, shadowY: shadowY))
    }
}
