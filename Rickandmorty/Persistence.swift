import CoreData

let ctx = PersistenceController.shared.container.viewContext

struct PersistenceController {
    
    let container: NSPersistentCloudKitContainer
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let character = CharacterDB(context: viewContext)
        character.id = 1
        character.name = "Rick Sanchez"
        let status = StatusDB(context: viewContext)
        status.id = UUID()
        status.status = "alive"
        character.species = "Human"
        let gender = GenderDB(context: viewContext)
        gender.id = UUID()
        gender.gender = "male"
        let origin = OriginDB(context: viewContext)
        origin.id = UUID()
        origin.origin = "Earth (C-137)"
        let location = LocationDB(context: viewContext)
        location.id = UUID()
        location.location = "Citadel of Ricks "
        character.url = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Rickandmorty")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

func testCharacter() -> CharacterDB {
    let context = PersistenceController.preview.container.viewContext
    
    let character = CharacterDB(context: context)
    character.id = 1
    character.name = "Rick Sanchez"
    let status = StatusDB(context: context)
    status.id = UUID()
    status.status = "alive"
    character.species = "Human"
    let gender = GenderDB(context: context)
    gender.id = UUID()
    gender.gender = "male"
    let origin = OriginDB(context: context)
    origin.id = UUID()
    origin.origin = "Earth (C-137)"
    let location = LocationDB(context: context)
    location.id = UUID()
    location.location = "Citadel of Ricks "
    character.url = ""
    
    return character
}
