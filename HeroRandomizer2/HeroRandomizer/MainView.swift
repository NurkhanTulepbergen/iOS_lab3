import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            ContentView(viewModel: viewModel)
                .tabItem {
                    Label("Randomizer", systemImage: "dice.fill")
                }
            
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
