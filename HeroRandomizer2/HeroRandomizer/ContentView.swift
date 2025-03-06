import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let hero = viewModel.selectedHero {
                    VStack(spacing: 16) {
                        AsyncImage(url: hero.imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 280)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 280)
                                    .cornerRadius(12)
                                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                            case .failure:
                                Color.red
                                    .frame(width: 200, height: 280)
                                    .cornerRadius(12)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: hero)
                        
                        Text(hero.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("🧠 Intelligence:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.intelligence)")
                            }
                            HStack {
                                Text("💪 Strength:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.strength)")
                            }
                            HStack {
                                Text("⚡ Speed:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.speed)")
                            }
                            HStack {
                                Text("🏋️ Durability:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.durability)")
                            }
                            HStack {
                                Text("✊ Power:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.power)")
                            }
                            HStack {
                                Text("🎯 Combat:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.powerstats.combat)")
                            }
                            HStack {
                                Text("🚻 Gender:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.appearance.gender)")
                            }
                            HStack {
                                Text("📏 Height:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.randomHeight)")
                            }
                            HStack {
                                Text("⚖️ Weight:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.randomWeight)")
                            }
                            HStack {
                                Text("👁 Eye Color:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(viewModel.selectedHero?.appearance.eyeColor ?? "Unknown")")
                            }
                            HStack {
                                Text("💇 Hair Color:")
                                    .frame(minWidth: 120, alignment: .leading)
                                Text("\(hero.appearance.hairColor)")
                            }
                        }
                        .padding(4)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }
                    .padding()
                    
                } else {
                    Text("Нажмите на кнопку, чтобы получить героя!")
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer()
                
                HStack {
                    Button(action: {
                        Task {
                            await viewModel.fetchHero()
                        }
                    }) {
                        Text("🎲 Roll Hero")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    
                    if let hero = viewModel.selectedHero {
                        Button(action: {
                            viewModel.toggleFavorite(hero)
                        }) {
                            Image(systemName: viewModel.isFavorite(hero) ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(viewModel.isFavorite(hero) ? Color.red : Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.trailing, 20)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.yellow)
                            .frame(width: 24, height: 24)
                            .padding(12)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
}

#Preview {
    let viewModel = ViewModel()
    ContentView(viewModel: viewModel)
}
