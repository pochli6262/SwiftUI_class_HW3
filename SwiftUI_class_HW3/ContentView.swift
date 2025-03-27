import SwiftUI
import MapKit


struct Pokemon: Equatable{
    let name: String
    let property: String
    let weak: String
    let height: Float
    let weight: Float
    let ability: String
    let classification: String
    let imageName: String
    let website: String
}


struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    

    // array
    let pokemons = [
        Pokemon(name: "小火龍", property: "火", weak: "水", height: 0.6, weight: 8.5, ability: "猛火", classification: "蜥蜴寶可夢", imageName: "小火龍", website: "https://www.youtube.com/watch?v=PiFIGwSlOzo"),
        Pokemon(name: "火恐龍", property: "火", weak: "水", height: 1.1, weight: 19.0, ability: "猛火", classification: "火焰寶可夢", imageName: "火恐龍", website: "https://www.youtube.com/watch?v=1wdmlyM4E0w"),
        Pokemon(name: "噴火龍", property: "火", weak: "水", height: 1.7, weight: 90.5, ability: "猛火", classification: "火焰寶可夢", imageName: "噴火龍", website: "https://www.youtube.com/watch?v=7O-aAG25OxA"),
        Pokemon(name: "超級噴火龍X", property: "火", weak: "水", height: 1.7, weight: 110.5, ability: "硬爪", classification: "火焰寶可夢", imageName: "超級噴火龍X", website: "https://www.youtube.com/watch?v=sb9kqjD0etw"),
        Pokemon(name: "超級噴火龍Y", property: "火", weak: "水", height: 1.7, weight: 100.5, ability: "日照", classification: "火焰寶可夢", imageName: "超級噴火龍Y", website: "https://www.youtube.com/watch?v=sb9kqjD0etw"),
        Pokemon(name: "噴火龍超極巨化", property: "火", weak: "水", height: 28.0, weight: 999.9, ability: "猛火", classification: "火焰寶可夢", imageName: "噴火龍超極巨化", website: "https://www.youtube.com/watch?v=4zXVjFhMMrk")
    ]
    
    @State private var selectedPokemon: Pokemon?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 封面圖片
                PokemonCover()
                // 內容區塊下的半透明長方形
                BaseRectangle1()
                // 內容區塊
                VStack {
                    PokemonHandbook()
                    ZStack {
                        // 寶可夢圓形圖片下的半透明長方形
                        BaseRectangle2()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(pokemons, id: \.name) { pokemon in
                                    // 寶可夢圓形圖片
                                    PokemonCircleView(pokemon: pokemon, isSelected: selectedPokemon == pokemon)
                                        .onTapGesture {
                                            // If the same Pokemon is tapped again, deselect it
                                            if selectedPokemon == pokemon {
                                                selectedPokemon = nil
                                            } else {
                                                selectedPokemon = pokemon
                                            }
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                    
                    if let selected = selectedPokemon {
                        // 寶可夢各種屬性圖形框
                        PokemonDetailView(pokemon: selected)
                            .padding(.top, 20)
                            .transition(.opacity)
                    } else {
                        // 請點擊寶可夢查看詳情
                        Tap2View()
                    }
                    // 寶可夢中心文字
                    PokemonCenter()
                    // 寶可夢中心地圖
                    MapOfPokemonCenter()
                }
                .padding(.bottom, 30)
            }
            
        }
        // 背景圖片
        .background(
            BackgroundPicture()
        )
        .edgesIgnoringSafeArea(.top)
       
    }
}

#Preview {
    ContentView()
}

struct PokemonCover: View {
    var body: some View {
        Image("寶可夢封面")
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 250)
            .clipShape(.rect(cornerRadius: 20))
            .padding(.top, 60)
            .padding(.horizontal, 15)
    }
}

struct PokemonDescription: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("寶可夢是充滿著許多秘密的神祕生物。一些寶可夢跟人類一起生活，一些是生活在野外草地或是洞穴、或是海洋中，但很多關於他們的生態依舊是未知。他們主要的特徵之一是一個精靈球收服他們，這也讓他們能夠被隨身攜帶。")
            .font(.headline)
            .bold()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(.horizontal, 20)
    }
}

struct BaseRectangle1: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(colorScheme == .dark ? 0.5 : 0.1)
                .foregroundColor(Color.black)
                .frame(width: UIScreen.main.bounds.width - 30, height: 150)
                .cornerRadius(20)
                .padding(.top, 10)
                .padding(.horizontal, 15)
            
            PokemonDescription()
        }
    }
}

struct PokemonHandbook: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("Pokémon 圖鑑")
            .font(.largeTitle)
            .bold()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(.top, 20)
    }
}

struct BaseRectangle2: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Rectangle()
            .opacity(colorScheme == .dark ? 0.5 : 0.1)
            .foregroundColor(Color.black)
            .frame(width: UIScreen.main.bounds.width, height: 160)
            .cornerRadius(20)
            .padding(.top, 10)
    }
}

struct PokemonCenter: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("台北寶可夢中心")
            .font(.largeTitle)
            .bold()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding(.top, 20)
    }
}

struct MapOfPokemonCenter: View {
    var body: some View {
        Map {
            Marker("Taipei Pokemon Center", coordinate: CLLocationCoordinate2D(latitude: 25.036233, longitude: 121.567240))
        }
        .frame(height: 200)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct BackgroundPicture: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        colorScheme == .dark
        ? Image("暗寶可夢桌布")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * 0.1)
            .edgesIgnoringSafeArea(.all)
        : Image("寶可夢桌布")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * 0.1)
            .edgesIgnoringSafeArea(.all)
    }
}

struct Tap2View: View {
    var body: some View {
        Text("請點擊寶可夢查看詳情")
            .font(.title2)
            .foregroundColor(.gray)
            .padding(.top, 20)
    }
}
