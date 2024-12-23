//
//  CardWithShadow.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 23/12/24.
//

import SwiftUI

struct CardWithShadowModifier: ViewModifier {
    var cornerRadius: CGFloat
    var shadowRadius: CGFloat
    var shadowOpacity: Double
    var shadowColor: Color
    var backgroundColor: Color
    var shadowY: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                backgroundColor
                    .cornerRadius(cornerRadius)
                    .shadow(
                        color: shadowColor,
                        radius: shadowRadius,
                        x: 0,
                        y: shadowY
                    )
                    .opacity(shadowOpacity)
            )
    }
}
