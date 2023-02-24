import Foundation

public class MainVM : ObservableObject {
    
    @Published var characters: [Result] = []
    
    public init() {
        fetchData()
    }
    
    func fetchData() {
        get(url: EndPoint.characters, type: Info.self, onSuccess: { data in
            self.characters = data.results
        }, onFailure: { error in
            print(error)
        })
    }
    
}
