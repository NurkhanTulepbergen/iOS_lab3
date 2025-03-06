import SwiftUI

struct Hero: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let images: Image
    let powerstats: PowerStats
    let appearance: Appearance
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
    
    var randomHeight: String {
        appearance.height.randomElement() ?? "Unknown"
    }
    
    var randomWeight: String {
        appearance.weight.randomElement() ?? "Unknown"
    }
    
    struct Image: Codable {
        let md: String
    }
    
    struct PowerStats: Codable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Appearance: Codable {
        let gender: String
        let height: [String]
        let weight: [String]
        let eyeColor: String
        let hairColor: String
    }
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
            return lhs.id == rhs.id
        }
}


final class ViewModel: ObservableObject {
    @Published var selectedHero: Hero?
    @Published var favorites: [Hero] = [] {
        didSet { saveFavorites() }
    }
    
    private let favoritesKey = "favoriteHeroes"

    init() {
        loadFavorites()
    }

    func fetchHero() async {
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            await MainActor.run {
                self.selectedHero = heroes.randomElement()
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func toggleFavorite(_ hero: Hero) {
        if let index = favorites.firstIndex(where: { $0.id == hero.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(hero)
        }
    }

    func isFavorite(_ hero: Hero) -> Bool {
        return favorites.contains(where: { $0.id == hero.id })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([Hero].self, from: savedData) {
            favorites = decoded
        }
    }
}
