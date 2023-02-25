import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var vm = MainVM()
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.id)
    ])  var fetch:FetchedResults<CharacterDB>
    
    private var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    @State private var refreshID = UUID()
    
    var body: some View {
        CustomNavigation {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(fetch) { character in
                        GeometryReader { geometry in
                            
                            VStack(spacing: 10) {
                                
                                if #available(iOS 16.0, *) {
                                    NavigationLink(value: character) {
                                        VStack {
                                            ItemView(character: character)
                                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20 ), axis: (x:0, y:10.0, z:0))
                                        }
                                    }
                                } else {
                                    NavigationLink(destination: DetailView(character: character)) {
                                        ItemView(character: character)
                                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20 ), axis: (x:0, y:10.0, z:0))
                                    }
                                }
                                
                                Button (role: .destructive) {
                                    withAnimation {
                                        ctx.delete(character)
                                        try? ctx.save()
                                    }
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                        .padding()
                                        .background(Rectangle()
                                            .opacity(0.6)
                                            .foregroundColor(.white)
                                            .overlay(Material.thin)
                                            .cornerRadius(5))
                                }
                                .accessibilityIdentifier("btn")
                            }
                            

                        }
                        .frame(width: 264, height: UIScreen.main.bounds.height / 1.5)
                    }
                }
                .id(refreshID)
                .onReceive(self.didSave) { _ in
                    self.refreshID = UUID()
                }
                .padding()
                .accessibilityIdentifier("lista")
            }
            .navDestination(with: CharacterDB.self) { item in
                if #available(iOS 16.0, *) {
                    DetailView(character: item)
                }
            }
            .navigationTitle("Personajes")
        }
        .onAppear {
            vm.fetchData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
