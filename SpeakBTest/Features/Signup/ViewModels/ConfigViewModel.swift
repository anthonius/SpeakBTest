//
//  ConfigViewModel.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import Foundation

class ConfigViewModel: ObservableObject {
    /// Defining Question enum within this viewModel itself for better encapsulation and prevent unnecessary global scope
    private enum Question {
        static let fullscreenQuestion = "Is it presenting a fullscreen?"
        static let closeBtnQuestion = "Is the close button scrollable?"
        static let fontSizeQuestion = "Title font size"
        static let animationQuestion = "Bar animation delay"
        static let barWidthQuestion = "Bar width preference"
    }
    
    @Published var isPresentView: Bool = true
    @Published var isCloseBtnScrollable: Bool = false
    @Published var animationDelay: Double = 0.2
    @Published var titleFontSize: Int = 36
    @Published var barWidthPreference: String = Constants.Configuration.barProportionalWidth
    
    @Published var configs: [ConfigItem] = [
        ConfigItem(label: Question.fullscreenQuestion, type: .toggle(true)),
        ConfigItem(label: Question.closeBtnQuestion, type: .toggle(false)),
        ConfigItem(label: Question.fontSizeQuestion, type: .stepper(value: 36, range: 20...40)),
        ConfigItem(label: Question.animationQuestion, type: .slider(value: 0.2, range: 0.1...1.0)),
        ConfigItem(label: Question.barWidthQuestion, type: .picker(options: [Constants.Configuration.barStaticWidth, Constants.Configuration.barProportionalWidth], selected: Constants.Configuration.barProportionalWidth))
    ]
    
    /// Call this function everytime any config is changed
    func updateValues(id: UUID, newType: ConfigType) {
        guard let index = configs.firstIndex(where: { $0.id == id }) else {
            return
        }

        switch configs[index].type {
        case .toggle(let currentValue):
            guard let newValue = currentValue as Bool? else { return }
            configs[index].type = .toggle(newValue)
            if (configs[index].label == Question.fullscreenQuestion) {
                isPresentView = newValue
            } else if (configs[index].label == Question.closeBtnQuestion) {
                isCloseBtnScrollable = newValue
            }
        case .slider(let currentValue, let range):
            guard let newValue = currentValue as Double? else { return }
            configs[index].type = .slider(value: newValue, range: range)
            animationDelay = newValue
        case .stepper(let currentValue, let range):
            guard let newValue = currentValue as Int? else { return }
            configs[index].type = .stepper(value: newValue, range: range)
            titleFontSize = newValue
        case .picker(let options, let currentValue):
            guard let newValue = currentValue as String? else { return }
            configs[index].type = .picker(options: options, selected: newValue)
            barWidthPreference = newValue
        }
    }
}
