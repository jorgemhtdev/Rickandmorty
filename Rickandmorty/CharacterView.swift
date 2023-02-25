import SwiftUI

struct CharacterView: View {
    
    let img:String
    
    var body: some View {
        AsyncImage(url: URL(string: img), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(Color.black.opacity(0.5))

            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
                
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.black.opacity(0.5))

            @unknown default:
                Image(systemName: "exclamationmark.icloud")
                    .foregroundColor(Color.black.opacity(0.5))

            }
        }
    }
}
