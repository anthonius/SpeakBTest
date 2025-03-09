//
//  SignupView.swift
//  SpeakBTest
//
//  Created by Anthonius on 09/03/25.
//

import SwiftUI

struct SignupView: View {
    let originalRobotWidth: CGFloat = 187 // base value based on Figma design
    let originalRobotHeight: CGFloat = 160
    
    var barData: [BarModel] = [
        BarModel(initialHeight: 0, finalHeight: 66, label: "現在"),
        BarModel(initialHeight: 0, finalHeight: 100, label: "3ヶ月"),
        BarModel(initialHeight: 0, finalHeight: 220, label: "1年"),
        BarModel(initialHeight: 0, finalHeight: 300, label: "2年")
    ]
    
    private var linearBg: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.purpleBg]),
                       startPoint: .bottom,
                       endPoint: .top)
        .ignoresSafeArea()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                linearBg
                
                ScrollView {
                    VStack {
                        CloseBtnView(geometry: geometry)
                            .padding(.trailing, 20)
                        
                        Text("Hello")
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .scaledToFit()
                        Text("SpeakBUDDY")
                            .font(.system(size: 36, weight: .bold))
                            .scaledToFit()
                            .minimumScaleFactor(0.8)
                        
                        ZStack(alignment: .top) {
                            BarGraphView(geometry: geometry, barData: barData)
                            
                            Image("robot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: ScalingHelper.scale(originalRobotWidth, screenWidth: geometry.size.width), height: min(250, ScalingHelper.scale(originalRobotHeight, screenWidth: geometry.size.width)))
                                .offset(x: ScalingHelper.scale(-100, screenWidth: geometry.size.width), y: ScalingHelper.scale(-50, screenWidth: geometry.size.width))
                        }
                        .padding(.top, 60)
                        
                        Text("スピークバディで")
                            .font(.system(size: 20, weight: .semibold)) // sorry I can't find Hiragino Sans semibold font
                            .scaledToFit()
                            .minimumScaleFactor(0.8)
                            .padding(.top, 12)
                        
                        LinearGradientText("レベルアップ")
                            .scaledToFit()
                            .minimumScaleFactor(0.8)
                            .padding(.top, 1)
                        
                        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("プランに登録する")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .frame(width: 350, height: 50)
                                .background(Color.primaryBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        .padding(.top, 16)
                    }
                }
            }
        }
    }
}

/// Creating a separate subview to increase readability
private struct CloseBtnView: View {
    let geometry: GeometryProxy
    
    var body: some View {
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
    }
}

/// Creating a separate subview to increase readability
private struct BarGraphView: View {
    @State private var animate = false
    let geometry: GeometryProxy
    let barData: [BarModel]
    var proportionalBarWidth: CGFloat {
        return (geometry.size.width - 150)/CGFloat(barData.count)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 16) {
            ForEach(0..<barData.count, id: \.self) { index in
                VStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.gradientBottomBlue, Color.gradientTopBlue]), startPoint: .bottom, endPoint: .top))
                        .frame(width: proportionalBarWidth, height: animate ? barData[index].finalHeight : barData[index].initialHeight, alignment: .bottom)
                        .animation(.easeInOut(duration: 1.0).delay(Double(index) * 0.2), value: animate)
                    Text(barData[index].label)
                        .font(.system(size: ScalingHelper.scale(12, screenWidth: geometry.size.width), weight: .bold))
                }
            }
        }
        .frame(height: 300, alignment: .bottom)
        .padding()
        .onAppear() {
            animate = true
        }
    }
}

#Preview {
    SignupView()
}
