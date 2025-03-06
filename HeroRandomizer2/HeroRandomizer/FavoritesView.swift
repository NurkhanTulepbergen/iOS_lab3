import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List(viewModel.favorites) { hero in
                HStack {
                    AsyncImage(url: hero.imageUrl) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(hero.name)
                        .font(.headline)

                    Spacer()

                    Button(action: { viewModel.toggleFavorite(hero) }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("⭐ Favorites")
        }
    }
}
