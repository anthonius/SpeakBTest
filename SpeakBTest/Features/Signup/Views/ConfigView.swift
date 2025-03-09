//
//  ConfigView.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

struct ConfigView: View {
    @State private var isPresentView: Bool = true
    @State private var isModalPresented = false
    @State private var path: [String] = [] // Keeps track of the navigation path
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Image("robot")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Toggle("Is it presenting a fullscreen?", isOn: $isPresentView)
                
                if isPresentView {
                    /// Modal presentation
                    Button(action: {
                        isModalPresented.toggle()
                    }) {
                        Text("See the sign up screen")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(Color.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    .fullScreenCover(isPresented: $isModalPresented) {
                        SignupView() {
                            isModalPresented = false
                        }
                    }
                } else {
                    /// Push navigation
                    NavigationLink(value: "signup") {
                        Text("See the sign up screen")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(Color.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    .navigationDestination(for: String.self) { value in
                        if value == "signup" {
                            SignupView() {
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
