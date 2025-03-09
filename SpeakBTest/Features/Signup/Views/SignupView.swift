//
//  SignupView.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

struct SignupView: View {
    var barData: [BarModel] = [
        BarModel(height: 66, label: "現在"),
        BarModel(height: 100, label: "3ヶ月"),
        BarModel(height: 220, label: "1年"),
        BarModel(height: 300, label: "2年")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.purpleBg]),
                           startPoint: .bottom,
                           endPoint: .top)
            .ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Button tapped!")
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gray)
                                .padding(12)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(.trailing, 20)
                    
                    Text("Hello")
                        .font(.system(size: 36, weight: .bold))
                    Text("SpeakBUDDY")
                        .font(.system(size: 36, weight: .bold))
                    
                    Image("robot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 187, height: 160)
                    
                    HStack(alignment: .bottom, spacing: 16) {
                        ForEach(0..<barData.count, id: \.self) { index in
                            VStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 48, height: barData[index].height, alignment: .bottom)
                                Text(barData[index].label)
                                    .font(.system(size: 12, weight: .bold))
                            }
                        }
                    }
                    .frame(height: 300, alignment: .bottom)
                    .padding()
                    
                    Text("スピークバディで")
                    Text("レベルアップ")
                    
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        Text("プランに登録する")
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
