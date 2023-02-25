import SwiftUI

struct CharacterCoreDataView: View {
    
    let img:Data?
    
    var body: some View {
        if let imageData = img,  let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
            .transition(.scale(scale: 0.1, anchor: .center))
        } else {
            Image(systemName: "photo")
                .resizable()
                .foregroundColor(Color.black.opacity(0.5))
        }
    }
}
