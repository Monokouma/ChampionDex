import SwiftUI
import shared

struct MainUIView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = MainViewModel(
        getChampionsEntitiesUseCase: SharedDependencyFactory()
            .createGetChampionsUseCase(),
        getDetailledChampionEntitysUseCase: SharedDependencyFactory()
            .createGetDetailledChampionEntityUseCase()
    )

    @State private var isHorizontalMode = false
    @State private var isWelcomeScreenShowed: Bool = false
    @State private var selectedId: String?
    @State private var selectedKey: String = ""

    var body: some View {
        NavigationStack {
            if !isWelcomeScreenShowed {
                
                ChampionDexWelcomeScreen().onAppear(perform: {
                    playSound(sound: "welcome_sound", type: "mp3")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                        self.isWelcomeScreenShowed = true
                    })
                    
                })
            } else {
                ZStack {
                    if viewModel.isLoading {
                        ProgressView("Loading champions...")
                            .foregroundColor(.white)
                    } else {
                        
                        VStack(spacing: 20) {
                            if isHorizontalMode {
                                HorizontalTiltedPhotoScroll(
                                    championEntities: viewModel.championList) { id, key in
                                        
                                        selectedId = id
                                        selectedKey = key
                                    }
                            } else {
                                VerticalTiltedPhotoScroll(
                                    championEntities: viewModel.championList) { id, key in
                                        
                                        selectedId = id
                                        selectedKey = key
                                    }
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                isHorizontalMode = true
                            }) {
                                Image(systemName: "arrow.left.arrow.right")
                                    .resizable()
                                    .foregroundStyle(isHorizontalMode ? Color.yellow : Color.white)
                                    .frame(width: 28, height: 28)
                                    .padding(.top, 32).padding(.horizontal, 8)
                            }
                            
                            Button(action: {
                                isHorizontalMode = false
                            }) {
                                Image(systemName: "arrow.up.arrow.down")
                                    .resizable()
                                    .foregroundStyle(!isHorizontalMode ? Color.yellow : Color.white)
                                    .frame(width: 28, height: 28)
                                    .padding(.top, 32)
                                    .padding(.horizontal, 8)
                                    .padding(.trailing)
                            }
                            
                        }.padding()
                        
                        Spacer()
                    }
                }
                .background(Color.black)
                .ignoresSafeArea()
                
                .onReceive(
                    NotificationCenter.default.publisher(
                        for: UIApplication.didReceiveMemoryWarningNotification)
                ) { _ in
                    
                    URLCache.shared.removeAllCachedResponses()
                    print("Memory warning received - cleared URL cache")
                }

            }
        }.sheet(
item: $selectedId,
 content: { selectedId in
            
     DetailsUIView(
        id: selectedId,
        key: selectedKey
        
     )
        })
        .ignoresSafeArea()
    }
}

extension String: @retroactive Identifiable {
    public var id: String { self }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
