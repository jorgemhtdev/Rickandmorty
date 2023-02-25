import SwiftUI

struct ItemView: View {
    
    @Environment(\.colorScheme) var colorScheme

    let character:Result
    
    var body: some View {
        VStack(spacing: 25) {
            CharacterView(img: character.image)
                .clipShape(Circle())
                .frame(width: 180, height: 180)
                .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)

            Text(character.name)
                .titleTextStyle()

            Label("Status: \(character.status.rawValue)", systemImage: "doc.text.image.fill")
                .nameTextStyle()
            
            Label("Species: \(character.species)", systemImage: "info.circle")
                .nameTextStyle()

            Text("See more")
                .nameTextStyle()
                .padding([.leading, .trailing])
                .background(Rectangle()
                    .opacity(0.6)
                    .foregroundColor(.white)
                    .overlay(Material.thin)
                    .cornerRadius(5))

            
        }
        .padding().padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Rectangle()
            .foregroundColor(.white)
            .overlay(Material.ultraThin)
            .cornerRadius(20))
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 25, x: 0, y: 0)
        .padding()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(character: itemData)
    }
}
