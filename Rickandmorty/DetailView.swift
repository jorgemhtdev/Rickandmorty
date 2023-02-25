import SwiftUI

struct DetailView: View {
    
    @State private var presentSheet = false

    let item:Result

    var body: some View {
        Text(item.name)
        
        Text(item.status.rawValue)
        
        Button() {
            presentSheet = true
        } label: {
            Image(systemName: "menubar.arrow.up.rectangle")
                .foregroundColor(.primary)
                .font(.largeTitle)
        }
        .showSheetMap(presentSheet: $presentSheet) {
            SheetInfo(item: item)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: itemData)
    }
}
