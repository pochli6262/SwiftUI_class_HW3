// 圓形圖片的View
struct PokemonCircleView: View {
    
    @Environment(\.colorScheme) var colorScheme  // 偵測系統模式
    let pokemon: Pokemon

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
                    .frame(width: 110, height: 110)

                Circle()
//                    .fill(colorScheme == .dark ? .gray : .white)
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                    .frame(width: 100, height: 100)

                Image(pokemon.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            Text(pokemon.name)
                .foregroundColor(.blue)
                .font(.headline)
        }
    }
}

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @Environment(\.colorScheme) var colorScheme  // 偵測系統模式

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
                        .foregroundColor(colorScheme == .dark ? .cyan : .blue) // 深色模式用 cyan
//                        .underline()
                }
                .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Text("屬性: \(pokemon.property)")
                    Text("弱點: \(pokemon.weak)")
                    Text("身高: \(String(format: "%.1f", pokemon.height)) m")
                    Text("體重: \(String(format: "%.1f", pokemon.weight)) kg")
                    Text("特性: \(pokemon.ability)")
                    Text("分類: \(pokemon.classification)")
                    Text("性別: ♂︎/♀︎")
                }
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .white : .black) // 文字顏色適應模式
                .padding()
            }
        }
        .transition(.opacity)
//        .animation(.easeInOut, value: pokemon)
    }
}