import CoreData

extension NSManagedObject {
    static func tableEmpty(context:NSManagedObjectContext = ctx) -> Bool {
        guard let name = self.entity().name else {
            return false
        }
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        do {
            return try context.count(for: fetch) == 0
        } catch {
            return false
        }
    }
}
