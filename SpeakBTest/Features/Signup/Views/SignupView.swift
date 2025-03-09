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
    private var signUpBtnHeight: CGFloat = min(80, ScalingHelper.scale(50, screenWidth: UIScreen.main.bounds.width))
    
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
    
    private var signupBtn: some View {
        Button(action: {
            print("Button tapped!")
        }) {
            Text("プランに登録する")
                .font(.system(size: ScalingHelper.scale(16, screenWidth: UIScreen.main.bounds.width)))
                .foregroundColor(.white)
                .frame(width: min(500, ScalingHelper.scale(350, screenWidth: UIScreen.main.bounds.width)), height: signUpBtnHeight)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: signUpBtnHeight/2))
        }
    }
    
    var body: some View {
        ZStack {
            linearBg
            
            ScrollView {
                VStack {
                    CloseBtnView()
                        .padding(.trailing, 20)
                    
                    Text("Hello")
                        .font(.system(size: ScalingHelper.scale(36, screenWidth: UIScreen.main.bounds.width), weight: .bold))
                    Text("SpeakBUDDY")
                        .font(.system(size: ScalingHelper.scale(36, screenWidth: UIScreen.main.bounds.width), weight: .bold))
                    
                    ZStack(alignment: .top) {
                        BarGraphView(barData: barData)

                        Image("robot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: ScalingHelper.scale(originalRobotWidth, screenWidth: UIScreen.main.bounds.width), height: min(250, ScalingHelper.scale(originalRobotHeight, screenWidth: UIScreen.main.bounds.width)))
                            .offset(x: ScalingHelper.scale(-100, screenWidth: UIScreen.main.bounds.width), y: ScalingHelper.scale(-50, screenWidth: UIScreen.main.bounds.width))
                    }
                    .padding(.top, 60)
                    
                    Text("スピークバディで")
                        .font(.system(size: ScalingHelper.scale(20, screenWidth: UIScreen.main.bounds.width), weight: .semibold)) // sorry I can't find Hiragino Sans semibold font
                        .padding(.top, 12)
                    
                    LinearGradientText("レベルアップ", fontSize: ScalingHelper.scale(30, screenWidth: UIScreen.main.bounds.width))
                        .padding(.top, 1)
                    
                    signupBtn
                        .padding(.top, 16)
                }
            }
        }
    }
}

/// Creating a separate subview to increase readability
private struct CloseBtnView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                print("Button tapped!")
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: ScalingHelper.scale(20, screenWidth: UIScreen.main.bounds.width), weight: .bold))
                    .foregroundColor(.gray)
                    .padding(ScalingHelper.scale(12, screenWidth: UIScreen.main.bounds.width))
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
    let barData: [BarModel]
    var proportionalBarWidth: CGFloat {
        return (UIScreen.main.bounds.width - 150)/CGFloat(barData.count)
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
                        .font(.system(size: ScalingHelper.scale(12, screenWidth: UIScreen.main.bounds.width), weight: .bold))
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
