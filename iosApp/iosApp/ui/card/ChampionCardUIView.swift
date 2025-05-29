//
//  ChampionCardUIView.swift
//  iosApp
//
//  Created by Monokouma on 29/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI



struct LoLBorder: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.8, green: 0.6, blue: 0.2),
                            Color(red: 1.0, green: 0.84, blue: 0.0),
                            Color(red: 0.72, green: 0.53, blue: 0.04),
                            Color(red: 1.0, green: 0.84, blue: 0.0),
                            Color(red: 0.8, green: 0.6, blue: 0.2),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 4
                )
                .shadow(color: Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.4), radius: 6)
                .shadow(color: .black.opacity(0.3), radius: 3)
            
            
            RoundedRectangle(cornerRadius: 4)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.1, green: 0.1, blue: 0.15),
                            Color(red: 0.2, green: 0.2, blue: 0.25),
                            Color(red: 0.1, green: 0.1, blue: 0.15),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1
                )
                .padding(4)
            
            
            VStack {
                HStack {
                    CornerOrnament()
                    Spacer()
                    CornerOrnament()
                        .rotationEffect(.degrees(90))
                }
                Spacer()
                HStack {
                    CornerOrnament()
                        .rotationEffect(.degrees(-90))
                    Spacer()
                    CornerOrnament()
                        .rotationEffect(.degrees(180))
                }
            }
            .padding(6)
        }
        
        .drawingGroup()
    }
}


struct CornerOrnament: View {
    var body: some View {
        ZStack {
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: 15))
                path.addLine(to: CGPoint(x: 6, y: 9))
                path.addLine(to: CGPoint(x: 12, y: 12))
                path.addLine(to: CGPoint(x: 15, y: 6))
                path.addLine(to: CGPoint(x: 9, y: 0))
                path.addLine(to: CGPoint(x: 6, y: 6))
                path.addLine(to: CGPoint(x: 3, y: 3))
                path.addLine(to: CGPoint(x: 0, y: 9))
                path.closeSubpath()
            }
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.84, blue: 0.0),
                        Color(red: 0.8, green: 0.6, blue: 0.2),
                        Color(red: 1.0, green: 0.84, blue: 0.0),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.6), radius: 1)
            
            
            Circle()
                .fill(Color(red: 0.9, green: 0.7, blue: 0.1))
                .frame(width: 3, height: 3) 
                .offset(x: 4, y: 4)
        }
        .frame(width: 15, height: 15)
    }
}

