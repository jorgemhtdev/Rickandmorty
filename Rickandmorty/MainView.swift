import SwiftUI

struct MainView: View {
    
    @ObservedObject var vm = MainVM()
    
    var body: some View {
        CustomNavigation {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20){
                    ForEach(vm.characters) { item in
                        GeometryReader { geometry in
                            if #available(iOS 16.0, *) {
                                NavigationLink(value: item){
                                    ItemView(character: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20 ), axis: (x:0, y:10.0, z:0))
                                }
                            } else {
                                NavigationLink(destination: DetailView(item: item)) {
                                    ItemView(character: item)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20 ), axis: (x:0, y:10.0, z:0))
                                }
                            }
                        }
                        .frame(width: 264, height: UIScreen.main.bounds.height / 1.8)
                    }
                }
                .padding()
            }
            .navDestination(with: Result.self) { item in
                if #available(iOS 16.0, *) {
                    DetailView(item: item)
                }
            }
            .navigationTitle("Personajes")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
