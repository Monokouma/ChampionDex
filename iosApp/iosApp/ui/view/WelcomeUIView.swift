//
//  WelcomeUIView.swift
//  iosApp
//
//  Created by Monokouma on 29/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ChampionDexWelcomeScreen: View {
    @State private var animateRings = false
    @State private var animateGlow = false
    @State private var loadingProgress: CGFloat = 0.0
    @State private var loadingRotation: Double = 0
    @State private var showLoadingPulse = false
    
    var body: some View {
        ZStack {
            
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.2, blue: 0.3),
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color.black
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            
            VStack {
                HStack {
                    
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.cyan.opacity(0.1))
                        .frame(width: 80, height: 80)
                        .offset(x: 100, y: -80)
                }
                
                Spacer()
                
                HStack {
                    Circle()
                        .fill(Color.cyan.opacity(0.1))
                        .frame(width: 90, height: 90)
                        .offset(x: -120, y: 50)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.cyan.opacity(0.1))
                        .frame(width: 110, height: 110)
                        .offset(x: 120, y: 80)
                }
            }
            .padding()
            
            
            ZStack {
                
                
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.cyan,
                                Color.blue,
                                Color.cyan
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 320, height: 320)
                    .opacity(animateGlow ? 0.8 : 0.4)
                    .scaleEffect(animateGlow ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true),
                        value: animateGlow
                    )
                
                
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.1, green: 0.3, blue: 0.4).opacity(0.8),
                                Color(red: 0.05, green: 0.15, blue: 0.25).opacity(0.9),
                                Color.black.opacity(0.95)
                            ]),
                            center: .center,
                            startRadius: 50,
                            endRadius: 140
                        )
                    )
                    .frame(width: 280, height: 280)
                
                
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.cyan.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 80
                        )
                    )
                    .frame(width: 160, height: 160)
                    .opacity(animateGlow ? 0.7 : 0.3)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true),
                        value: animateGlow
                    )
                
                
                ZStack {
                    
                    
                    
                    Circle()
                        .trim(from: 0, to: loadingProgress)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.orange,
                                    Color.orange,
                                    Color.yellow,
                                    Color.orange
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(114))
                        .shadow(color: .orange, radius: 2, x: 0, y: 0)
                }
                
                
                Text("ChampionDex")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .cyan, radius: 8, x: 0, y: 0)
                
            }
        }
        .onAppear {
            animateRings = true
            animateGlow = true
            showLoadingPulse = true
            
            
            withAnimation(.easeInOut(duration: 6.0)) {
                loadingProgress = 1.0
            }
        }
    }
}

#Preview {
    ChampionDexWelcomeScreen()
}
