//
//  LinearGradientText.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

struct LinearGradientText: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let gradientColors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    init(_ text: String, fontSize: CGFloat = 30, fontWeight: Font.Weight = .bold, gradientColors: [Color] = [.gradientBottomBlue, .gradientTopBlue], startPoint: UnitPoint = .bottom, endPoint: UnitPoint = .top) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(.clear)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .mask(
                Text(text)
                    .font(.system(size: fontSize, weight: fontWeight))
            )
    }
}

#Preview {
    LinearGradientText("Test gradient text")
}
