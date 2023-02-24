import SwiftUI

struct CharacterView: View {
    
    let img:String
    
    var body: some View {
        AsyncImage(url: URL(string: img), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .resizable()
                
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
                
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
    }
}
