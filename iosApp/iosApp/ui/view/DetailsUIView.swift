//
//  DetailsUIView.swift
//  iosApp
//
//  Created by Monokouma on 29/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI
import shared

struct DetailsUIView: View {
    @State var id: String
    @State var key: String
    @State private var imageCache: UIImage?
    @StateObject private var audioManager = AudioManager()

    @StateObject var viewModel = MainViewModel(
        getChampionsEntitiesUseCase: SharedDependencyFactory()
            .createGetChampionsUseCase(),
        getDetailledChampionEntitysUseCase: SharedDependencyFactory()
            .createGetDetailledChampionEntityUseCase()
    )
    
    
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(id)_0.jpg")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .drawingGroup(opaque: false, colorMode: .nonLinear)
                        .blur(radius: 24)
                        .ignoresSafeArea(.all)
                case .empty:
                    placeholderView.ignoresSafeArea()
                case .failure(_):
                    placeholderView.ignoresSafeArea()
                @unknown default:
                    placeholderView.ignoresSafeArea()
                }
            }
            
            .onDisappear {
                imageCache = nil
                
                URLCache.shared.removeCachedResponse(
                    for: URLRequest(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(id)_0.jpg")!))
            }
            if let champion = viewModel.selectedChampion {
                VStack {
                    Text(champion.name)
                        .font(.custom("Copperplate", size: 52)) 
                        .foregroundColor(.white)
                    Spacer()
                    
                }
            } else if viewModel.isLoading {
                ProgressView("Loading champion...")
                    .foregroundColor(.white)
            }
        }.onAppear {
            viewModel.getDetailledChampionEntity(id: id)
            print("Loading champion with id: \(id)")
        }.background(.black)
       
    }
    
    private var placeholderView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                ProgressView()
                    .tint(.white)
            )
            
    }
}



#Preview {
    DetailsUIView(
        id: "Fiddlesticks",
        key: "69"
        
    )
}
