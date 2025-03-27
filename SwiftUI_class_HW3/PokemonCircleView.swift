import SwiftUI

struct PokemonCircleView: View {
    let pokemon: Pokemon
    let isSelected: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(width: isSelected ? 110 : 80, height: isSelected ? 110 : 80)

                Circle()
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.7) : Color.white.opacity(0.4))
                    .frame(width: isSelected ? 100 : 70, height: isSelected ? 100 : 70)

                Image(pokemon.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: isSelected ? 100 : 70, height: isSelected ? 100 : 70)
                    .clipShape(Circle())
            }
            Text(pokemon.name)
                .foregroundColor(.blue)
                .font(.headline)
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}


struct PokemonDetailView: View {
    let pokemon: Pokemon
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // 淺灰色圓角背景，適應深色模式
            RoundedRectangle(cornerRadius: 30)
                .fill(colorScheme == .dark ? Color.gray.opacity(0.4) : Color.gray.opacity(0.2))
                .frame(height: 600)
                .padding(.horizontal)

            VStack {
                Image(pokemon.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                // 超連結
                Link(destination: URL(string: pokemon.website)!) {
                    Text(pokemon.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .cyan : .blue)
                }
                .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        Text("屬性: \(pokemon.property)")
                            .bold()
                        Image(systemName: "flame")
                            .bold()
                    }
                    HStack{
                        Text("弱點: \(pokemon.weak)")
                            .bold()
                        Image(systemName: "drop.halffull")
                            .bold()
                    }
                    Text("身高: \(String(format: "%.1f", pokemon.height)) m")
                        .bold()
                    Text("體重: \(String(format: "%.1f", pokemon.weight)) kg")
                        .bold()
                    Text("特性: \(pokemon.ability)")
                        .bold()
                    Text("分類: \(pokemon.classification)")
                        .bold()
                    Text("性別: ♂︎/♀︎")
                        .bold()
                }
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: pokemon)
    }
}
