import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss

    @ObservedObject var character:CharacterDB
    
    @State private var name:String = ""
    @State private var species:String = ""
    @State private var status: Status = .alive
    @State private var gender: Gender = .male
    @State private var origin:String = ""
    @State private var location:String = ""
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.origin)
    ])  var originDB:FetchedResults<OriginDB>
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.location)
    ])  var locationDB:FetchedResults<LocationDB>

    var body: some View {
        
        Form {
            VStack(alignment: .leading) {
                Text("Name:")
                TextField("Write the name", text: $name)
                    .accessibilityIdentifier("name")
            }
            
            VStack(alignment: .leading) {
                Picker("Status: ", selection: $status) {
                    ForEach(Status.allCases, id: \.self) { status in
                        Text("\(status.stringValue())")
                        .tag(status)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text("Species")
                TextField("Write the specie", text: $species)
            }
            
            VStack(alignment: .leading) {
                Picker("Gender:", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text("\(gender.stringValue())")
                        .tag(gender)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Picker("Origin:", selection: $origin) {
                    Text(origin)
                        .tag(origin)
                    
                    ForEach(originDB) { origin in
                        Text("\(origin.origin ?? "")")
                            .tag(origin.origin ?? "")
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Picker("Location:", selection: $location) {
                    Text(location)
                        .tag(location)
                    
                    ForEach(locationDB) { origin in
                        Text("\(origin.location ?? "")")
                            .tag(origin.location ?? "")
                    }
                }
            }
        }
        .onAppear {
            name = character.name ?? ""
            species = character.species ?? ""
            
            if let statusEnum = Status(rawValue: character.status?.status ?? "") {
                status = statusEnum
            }
            
            if let genderEnum = Gender(rawValue: character.gender?.gender ?? "") {
                gender = genderEnum
            }
            
            origin = character.origin?.origin ?? ""
            location = character.location?.location ?? ""
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .navigationBarTitle("Detail character", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                character.name = name
                character.species = species
                character.status = getStatus(status: status.rawValue)
                character.gender = getGender(gender: gender.rawValue)
                character.origin = getOrigin(origin: origin)
                character.location = getLocation(location: location)

                try? ctx.save()
            
                dismiss()
            }, label: {
                Text("Save")
            })
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: testCharacter())
    }
}
