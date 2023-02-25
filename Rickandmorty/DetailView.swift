import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var presentSheet = false

    let character:CharacterDB
    
    @State var name:String = ""
    @State var status:String = ""

    var body: some View {
        
        Form {
            VStack(alignment: .leading) {
                Text("name:")
                TextField("Write the name", text: $name)
            }
        }
        .onAppear {
            name = character.name ?? ""
            status = character.status?.status ?? ""
            try? ctx.save()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .navigationBarTitle("Detail character", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                dismiss()
            }, label: {
                Text("Save")
            })
        )
//        Button() {
//            presentSheet = true
//        } label: {
//            Image(systemName: "menubar.arrow.up.rectangle")
//                .foregroundColor(.primary)
//                .font(.largeTitle)
//        }
//        .showSheet(presentSheet: $presentSheet) {
//            //SheetInfo(item: character)
//        }
//        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: testCharacter())
    }
}
