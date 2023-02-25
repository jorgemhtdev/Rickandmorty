import Foundation
import CoreData

func cargaArtesanal(values: [Result]) {
    ctx.performAndWait {
        values.forEach { character in
            let newCharacter = CharacterDB(context: ctx)
            newCharacter.id = Int32(character.id)
            newCharacter.name = character.name
            
            if let status = createUpdateStatus(status: character.status.rawValue) {
                newCharacter.status = status
            }
            
            newCharacter.species = character.species
            
            if let gender = createUpdateGender(gender: character.gender.rawValue) {
                newCharacter.gender = gender
            }
            
            if let origin = createUpdateOrigin(origin: character.origin.name) {
                newCharacter.origin = origin
            }
            
            if let location = createUpdateLocation(location: character.location.name) {
                newCharacter.location = location
            }
            
            newCharacter.url = character.url
            newCharacter.imageUrl = character.image
        }
        
        try? ctx.save()
    }
    
}

func cargaImgArtesanal() {
    let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()
    
    do {
        let characters = try ctx.fetch(fetchRequest)
        
        let group = DispatchGroup()
        
        for character in characters {

            guard character.image == nil, let url = URL(string: character.imageUrl ?? "") else {
                continue
            }
            
            group.enter()
            
            downloadAndSaveImage(from: url) { imageData in
                character.image = imageData
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            try? ctx.save()
        }
        
    } catch {
        print("Error fetching characters: \(error.localizedDescription)")
    }
}

func getStatus(status:String) -> StatusDB? {
    let queryStatus:NSFetchRequest<StatusDB> = StatusDB.fetchRequest()
    queryStatus.predicate = NSPredicate(format: "%K = %@", #keyPath(StatusDB.status), status)
    do {
        let fetch = try ctx.fetch(queryStatus)
        if let statusFetched = fetch.first {
            return statusFetched
        }
    } catch {
        print("Error en la consulta del Status \(error)")
    }
    return nil
}

func getGender(gender:String) -> GenderDB? {
    let queryGender:NSFetchRequest<GenderDB> = GenderDB.fetchRequest()
    queryGender.predicate = NSPredicate(format: "%K = %@", #keyPath(GenderDB.gender), gender)
    do {
        let fetch = try ctx.fetch(queryGender)
        if let genderFetched = fetch.first {
            return genderFetched
        }
    } catch {
        print("Error en la consulta del GENDER \(error)")
    }
    return nil
}

func getOrigin(origin:String) -> OriginDB? {
    let queryOrigin:NSFetchRequest<OriginDB> = OriginDB.fetchRequest()
    queryOrigin.predicate = NSPredicate(format: "%K = %@", #keyPath(OriginDB.origin), origin)
    do {
        let fetch = try ctx.fetch(queryOrigin)
        if let originFetched = fetch.first {
            return originFetched
        }
    } catch {
        print("Error en la consulta del ORIGIN \(error)")
    }
    return nil
}

func getLocation(location:String) -> LocationDB? {
    let queryLocation:NSFetchRequest<LocationDB> = LocationDB.fetchRequest()
    queryLocation.predicate = NSPredicate(format: "%K = %@", #keyPath(LocationDB.location), location)
    do {
        let fetch = try ctx.fetch(queryLocation)
        if let locationFetched = fetch.first {
            return locationFetched
        }
    } catch {
        print("Error en la consulta del LOCATION \(error)")
    }
    return nil
}

func createUpdateStatus(status:String) -> StatusDB? {
    let queryStatus:NSFetchRequest<StatusDB> = StatusDB.fetchRequest()
    queryStatus.predicate = NSPredicate(format: "%K = %@", #keyPath(StatusDB.status), status)
    do {
        let fetch = try ctx.fetch(queryStatus)
        if let statusFetched = fetch.first {
            return statusFetched
        } else {
            let newStatus = StatusDB(context: ctx)
            newStatus.id = UUID()
            newStatus.status = status
            return newStatus
        }
    } catch {
        print("Error en la consulta del Status \(error)")
    }
    return nil
}

func createUpdateGender(gender:String) -> GenderDB? {
    let queryGender:NSFetchRequest<GenderDB> = GenderDB.fetchRequest()
    queryGender.predicate = NSPredicate(format: "%K = %@", #keyPath(GenderDB.gender), gender)
    do {
        let fetch = try ctx.fetch(queryGender)
        if let genderFetched = fetch.first {
            return genderFetched
        } else {
            let newGender = GenderDB(context: ctx)
            newGender.id = UUID()
            newGender.gender = gender
            return newGender
        }
    } catch {
        print("Error en la consulta del GENDER \(error)")
    }
    return nil
}

func createUpdateOrigin(origin:String) -> OriginDB? {
    let queryOrigin:NSFetchRequest<OriginDB> = OriginDB.fetchRequest()
    queryOrigin.predicate = NSPredicate(format: "%K = %@", #keyPath(OriginDB.origin), origin)
    do {
        let fetch = try ctx.fetch(queryOrigin)
        if let originFetched = fetch.first {
            return originFetched
        } else {
            let newOrigin = OriginDB(context: ctx)
            newOrigin.id = UUID()
            newOrigin.origin = origin
            return newOrigin
        }
    } catch {
        print("Error en la consulta del ORIGIN \(error)")
    }
    return nil
}

func createUpdateLocation(location:String) -> LocationDB? {
    let queryLocation:NSFetchRequest<LocationDB> = LocationDB.fetchRequest()
    queryLocation.predicate = NSPredicate(format: "%K = %@", #keyPath(LocationDB.location), location)
    do {
        let fetch = try ctx.fetch(queryLocation)
        if let locationFetched = fetch.first {
            return locationFetched
        } else {
            let newLocation = LocationDB(context: ctx)
            newLocation.id = UUID()
            newLocation.location = location
            return newLocation
        }
    } catch {
        print("Error en la consulta del LOCATION \(error)")
    }
    return nil
}
