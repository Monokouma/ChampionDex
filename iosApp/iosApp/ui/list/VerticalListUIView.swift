//
//  VerticalListUIView.swift
//  iosApp
//
//  Created by Monokouma on 29/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared


struct VerticalTiltedPhotoScroll: View {
    let championEntities: [ChampionEntity]
    
    let onChampionClick: (String, String) -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(Array(championEntities.enumerated()), id: \.offset) {
                    index, championEntity in
                    
                    VerticalPhotoCard(
                        imageName: championEntity.verticalImageUrl,
                        index: index,
                        availableHeight: 400,
                        championName: championEntity.name,
                        championTitle: championEntity.title,
                        championId: championEntity.id,
                        onChampionClick: { id in
                            onChampionClick(id, championEntity.key)
                        }
                    )
                }
            }
            .padding(.vertical, 20)
        }
    }
}


struct VerticalPhotoCard: View {
    let imageName: String
    let index: Int
    
    let availableHeight: CGFloat
    let championName: String
    let championTitle: String
    let championId: String
    
    @State private var isPressed = false
    @State private var imageCache: UIImage?
    
    let onChampionClick: (String) -> Void
    
    var rotationAngle: Double {
        return 4
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(
                width: 500,
                height: 300
            )
            .overlay(
                AsyncImage(url: URL(string: imageName)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 320
                            )
                            .clipped()
                            .drawingGroup(opaque: true, colorMode: .nonLinear)
                            .overlay(LoLBorder())
                            .overlay(textOverlay)
                            .onTapGesture {
                                handleTap(championId: championId)
                            }
                    case .failure(_):
                        placeholderView
                    case .empty:
                        placeholderView
                    @unknown default:
                        placeholderView
                    }
                }
                
                    .onDisappear {
                        imageCache = nil
                        
                        URLCache.shared.removeCachedResponse(
                            for: URLRequest(url: URL(string: imageName)!))
                    }
            )
            .contentShape(
                Rectangle()
                    .offset(x: -80)
            )
            .rotationEffect(.degrees(rotationAngle))
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isPressed)
    }
    
    private var textOverlay: some View {
        
        VStack {
            
            Spacer(minLength: 250)
            Text(championName)
                .foregroundStyle(Color.white)
                .bold()
                .font(.system(size: 18, weight: .bold))
                .shadow(color: .black.opacity(0.9), radius: 2, x: 2, y: 2)
                .shadow(color: .black.opacity(0.6), radius: 6, x: 0, y: 0)
                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 0)
                .rotationEffect(.degrees(-4))
            
            Text(championTitle)
                .foregroundStyle(Color.white)
                .bold()
                .font(.system(size: 14, weight: .medium))
                .shadow(color: .black.opacity(0.9), radius: 2, x: 2, y: 2)
                .shadow(color: .black.opacity(0.6), radius: 6, x: 0, y: 0)
                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 0)
                .rotationEffect(.degrees(-4))
            Spacer()
        }
        
    }
    
    private var placeholderView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(
                maxWidth: .infinity,
                minHeight: availableHeight + 100
            )
            .overlay(
                ProgressView()
                    .tint(.white)
            )
            .overlay(LoLBorder())
    }
    
    private func handleTap(championId: String) {
        withAnimation(.easeInOut(duration: 0.1)) {
            isPressed = true
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = false
                onChampionClick(championId)
            }
        }
    }
}
