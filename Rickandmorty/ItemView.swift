import SwiftUI

struct ItemView: View {
    
    let character:Result
    
    var body: some View {
        VStack {
            CharacterView(img: character.image)
                .frame(width: 250, height: 250)
            
            Text(character.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            Text("Status: \(character.status.rawValue)")
                .font(.headline)
                .padding(.top, 8)
            
            Text("Species: \(character.species)")
                .font(.headline)
                .padding(.top, 8)
            
            Link("See more", destination: URL(string: character.url)!)
                .font(.headline)
                .padding(.top, 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(character: itemData)
    }
}
