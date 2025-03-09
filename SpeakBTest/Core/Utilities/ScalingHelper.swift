//
//  ScalingHelper.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import Foundation

struct ScalingHelper {
    static func scale(_ value: CGFloat, screenWidth: CGFloat) -> CGFloat {
        let baseWidth: CGFloat = 390 // Reference screen width from Figma using iPhone 14
        return (value / baseWidth) * screenWidth // Converting the value into a scale factor
    }
}
