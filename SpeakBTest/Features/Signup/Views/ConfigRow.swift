//
//  ConfigRow.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

struct ConfigRow: View {
    @Binding var item: ConfigItem
    var onTypeChange: (ConfigType) -> Void
    
    var body: some View {
        HStack {
            Text(item.label)
            
            Spacer()
            
            switch item.type {
            case .toggle(let value):
                Toggle("", isOn: Binding(
                    get: { value },
                    set: {
                        item.type = .toggle($0)
                        onTypeChange(.toggle($0))
                    }
                ))
            case .picker(let options, let selected):
                Picker("", selection: Binding(
                    get: { selected },
                    set: {
                        item.type = .picker(options: options, selected: $0)
                        onTypeChange(.picker(options: options, selected: $0))
                    }
                )) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
            case .stepper(let value, let range):
                Stepper("(\(value) pt)", value: Binding( // For the sake of simplicity, hardcoding this only for font size question
                    get: { value }, set: {
                        item.type = .stepper(value: $0, range: range)
                        onTypeChange(.stepper(value: $0, range: range))
                    }
                ), in: range)
            case .slider(let value, let range):
                HStack {
                    Text("\(String(format: "%.2f", value))s") // For the sake of simplicity, hardcoding this only for animation delay question
                    Slider(value: Binding(
                        get: { value },
                        set: {
                            item.type = .slider(value: $0, range: range)
                            onTypeChange(.slider(value: $0, range: range))
                        }
                    ), in: range)
                }
            }
        }
    }
}
