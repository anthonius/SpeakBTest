//
//  ConfigView.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

/// Providing a configuration page to showcase several behaviors adjustments
struct ConfigView: View {
    @StateObject private var configVm = ConfigViewModel()
    
    @State private var isModalPresented = false
    @State private var path: [String] = [] // Keeps track of the navigation path
    
    private var seeBtnText: some View {
        Text("See the sign up screen")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .frame(width: 350, height: 50)
            .background(Color.primaryBlue)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Image("robot")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Hi! Let's configure the sign up screen.")
                    .font(.title3)
                
                Divider()
                
                List {
                    ForEach($configVm.configs) { $config in
                        ConfigRow(item: $config) { newType in
                            configVm.updateValues(id: config.id, newType: newType)
                        }
                    }
                }
                .listStyle(.plain)
                
                if configVm.isPresentView {
                    /// Modal presentation
                    Button(action: {
                        isModalPresented.toggle()
                    }) {
                        seeBtnText
                    }
                    .fullScreenCover(isPresented: $isModalPresented) {
                        SignupView(isCloseBtnScrollable: configVm.isCloseBtnScrollable,
                                   animationDelay: configVm.animationDelay,
                                   titleFontSize: configVm.titleFontSize,
                                   barWidthPreference: configVm.barWidthPreference) {
                            isModalPresented = false
                        }
                    }
                } else {
                    /// Push navigation
                    NavigationLink(value: "signup") {
                        seeBtnText
                    }
                    .navigationDestination(for: String.self) { value in
                        if value == "signup" {
                            SignupView(isCloseBtnScrollable: configVm.isCloseBtnScrollable,
                                       animationDelay: configVm.animationDelay,
                                       titleFontSize: configVm.titleFontSize,
                                       barWidthPreference: configVm.barWidthPreference) {
                                path.removeLast()  // This pops the view from the navigation stack
                            }
                        }
                    }
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    ConfigView()
}
