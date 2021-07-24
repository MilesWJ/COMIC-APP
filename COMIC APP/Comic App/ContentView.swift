import SwiftUI

struct Option: Hashable {
    let title: String
    let imageName: String
    
}

struct ContentView: View {
    @State var currentOption = 0
    let options: [Option] = [
        .init(title: "HOME", imageName: "house"),
        .init(title: "ABOUT", imageName: "info.circle")
    ]
    
    var body: some View {
        NavigationView{
            ListView(options: options,
            currentSelection: $currentOption
            )
            switch currentOption{
            case 1:
                Text("This app was created using Swift's UI package. This was my first attempt to learn and create something from scratch.\nThis is a standard comic book reccomendation app.")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 750)
    }
}

struct MainView: View {
    let coloums: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    let ComicCovers = Array(1...6).map { "ComicCover\($0)" }

    var body: some View {
        VStack{
            Image("COMIC APP")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Check out the comics below!")
                .font(.title)
            
            LazyVGrid(columns: coloums){
                ForEach(ComicCovers, id: \.self) {imageName in
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            
            Spacer()
            Text("Created by ") +
            Text("Miles James ").bold() +
            Text("on ") +
            Text("7/23/2021 ").bold() +
            Text("with ❤️")
            
        }
    }
}

struct ListView: View {
    let options: [Option]
    @Binding var currentSelection: Int
    var body: some View {
        VStack {
            let current = options[currentSelection]
            ForEach(options, id: \.self) {option in
                HStack{
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text(option.title).bold()
                        .foregroundColor(current == option ? Color.red : Color.white)
                    
                    Spacer()
                }
                .padding(12)
                .onTapGesture {
                    if currentSelection == 1{
                        currentSelection = 0
                    } else {
                        self.currentSelection = 1
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
