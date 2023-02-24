import SwiftUI

struct MainView: View {
    
    @ObservedObject var vm = MainVM()
    
    var body: some View {
        CustomNavigation {
            List(){
                ForEach(vm.characters) {item in
                    if #available(iOS 16.0, *) {
                        NavigationLink(value: item){
                            ItemView(character: item)
                        }
                        .listRowSeparator(.hidden)
                        
                    } else {
                        NavigationLink(destination: DetailView()) {
                            ItemView(character: item)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .navDestination(with: Item.self) { item in
                if #available(iOS 16.0, *) {
                    DetailView()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Personajes")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
