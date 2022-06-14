//
//  CoreDataManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 11.06.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Things")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    private var context: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    private init() {}
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Сохранено в coreData")
            } catch let error {
                print("Ошибка при попытке сохранить context: \(error)")
            }
        }
    }
    
    func save(from thing: Thing, imageData: Data) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CoreDataThing", in: context) else { return }
        guard let coreDataThing = NSManagedObject(entity: entityDescription, insertInto: context) as? CoreDataThing else { return }
        
        coreDataThing.name = thing.name
        coreDataThing.cost = thing.cost
        coreDataThing.date = thing.date
        coreDataThing.imageData = imageData
        
        saveContext()
    }
    
    func fetchData() -> [CoreDataThing] {
        var things: [CoreDataThing]!
        let fetchRequest: NSFetchRequest<CoreDataThing> = CoreDataThing.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            things = try context.fetch(fetchRequest)
        } catch let error {
            print("Ошибка при получении данных из coreData : \(error)")
        }
        
        return things
    }
    
    func delete(thing: CoreDataThing) {
        context.delete(thing)
        saveContext()
    }
}
