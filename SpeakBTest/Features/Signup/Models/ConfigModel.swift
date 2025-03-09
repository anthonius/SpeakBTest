//
//  ConfigModel.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import Foundation

/// Using associated value to avoid needing extra variables in ConfigItem
enum ConfigType {
    case toggle(Bool)
    case picker(options: [String], selected: String)
    case stepper(value: Int, range: ClosedRange<Int>)
    case slider(value: Double, range: ClosedRange<Double>)
}

struct ConfigItem: Identifiable {
    let id = UUID()
    let label: String
    var type: ConfigType
}
