//
//  BarModel.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import Foundation

struct BarModel: Identifiable {
    let id = UUID()
    var initialHeight: CGFloat // for animation purpose
    let finalHeight: CGFloat
    let label: String
}
