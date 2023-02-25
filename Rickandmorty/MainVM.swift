import Foundation
import CoreData

public class MainVM : ObservableObject {
    
    func fetchData() {
        get(url: EndPoint.characters, type: Info.self, onSuccess: { data in
            if CharacterDB.tableEmpty() {
               cargaArtesanal(values: data.results)
            }
        }, onFailure: { error in
            print(error)
        })
    }
    
    func refreshImagesCharacters() {
        cargaImgArtesanal()
    }
}

