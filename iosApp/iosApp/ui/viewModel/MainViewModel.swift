//
//  MainViewModel.swift
//  iosApp
//
//  Created by Monokouma on 22/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Combine
import shared

class MainViewModel: ObservableObject {
    
    private let getChampionsEntitiesUseCase: GetChampionsEntitiesUseCase
    private let getDetailledChampionEntitysUseCase: GetDetailledChampionEntityUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var championList: [ChampionEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedChampion: DetailledChampionEntity? = nil
    
    init(getChampionsEntitiesUseCase: GetChampionsEntitiesUseCase, getDetailledChampionEntitysUseCase: GetDetailledChampionEntityUseCase) {
        self.getChampionsEntitiesUseCase = getChampionsEntitiesUseCase
        self.getDetailledChampionEntitysUseCase = getDetailledChampionEntitysUseCase
        
        
        getList()
    }
    
    func getDetailledChampionEntity(id: String) {
        isLoading = true
        errorMessage = nil
        
        Future<DetailledChampionEntity?, Error> { promise in
            Task {
                do {
                    let champion = try await self.getDetailledChampionEntitysUseCase.invoke(id: id)
                    
                    promise(.success(champion))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.selectedChampion = nil
                }
            },
            receiveValue: { champion in
                self.selectedChampion = champion
            }
        )
        .store(in: &cancellables)
    }

    
    func getList() {
        
        isLoading = true
        errorMessage = nil
        
        Future<[ChampionEntity], Error> { promise in
            Task {
                do {
                    
                    let champions = try await self.getChampionsEntitiesUseCase.invoke()
                    
                    promise(.success(champions))
                } catch {
                    
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                
                self.isLoading = false
            },
            receiveValue: { champions in
                
                self.championList = champions
            }
        )
        .store(in: &cancellables)
    }
    
    
    func retry() {
        getList()
    }
}
