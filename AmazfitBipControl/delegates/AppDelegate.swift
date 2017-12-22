//
//  AppDelegate.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit
import CoreData
import CoreBluetooth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabController: UITabBarController?
    var messagesArray = [String]()
    var defaultServices = [String: DefaultService]()
    var defaultCharacteristics = [String: DefaultCharacteristic]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Utils.log("didFinishLaunchingWithOptions", args: nil)
//        Utils.log("AppDelegate.amazfitServices", args: self.amazfitServices!.services)
        refreshMessages(callback: nil)
        refreshServices(callback: nil)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: tt(t:e:))
        return true
    }
    
    func tt(t: Bool, e: Error?) {
        
    }
    
    func refreshMessages(callback: (()->Void)?){
        Utils.log("AppDelegate.refreshMessages", args: nil)
        let context: NSManagedObjectContext = persistentContainer.viewContext
        self.messagesArray.removeAll()
        let entity = NSEntityDescription.entity(forEntityName: "MessagesHistory", in: context)
        let messagesFetch = NSFetchRequest<NSFetchRequestResult>.init()
        //let sort = NSSortDescriptor(key: "date", ascending: true)
        messagesFetch.entity = entity
        //messagesFetch.sortDescriptors?.append(sort)
        do {
            var table = [MessagesHistory]()
            try table = context.fetch(messagesFetch) as! [MessagesHistory]
            for row in table {
                self.messagesArray.append(row.message!)
            }
            if callback != nil {
                callback!()
            }
        } catch {
            fatalError("Failed to fetch messages: \(error)")
        }
    }
    
    func addMessages(id: Int, message: String) {
        Utils.log("AppDelegate.addMessages", args: nil)
        let context = persistentContainer.viewContext
        let messagesHistory = NSEntityDescription.insertNewObject(forEntityName: "MessagesHistory", into: context)
        messagesHistory.setValue(id, forKey: "id")
        messagesHistory.setValue(message, forKey: "message")
        do {
            try context.save()
        } catch {
            fatalError("Failed to add messages: \(error)")
        }
    }
    
    func clearMessages(callback: (()->Void)?) {
        Utils.log("AppDelegate.clearMessages", args: nil)
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MessagesHistory", in: context)
        let messagesFetch = NSFetchRequest<NSFetchRequestResult>.init()
        messagesFetch.entity = entity
        do {
            var table = [MessagesHistory]()
            try table = context.fetch(messagesFetch) as! [MessagesHistory]
            for row in table {
                context.delete(row)
            }
            try context.save()
            self.messagesArray.removeAll()
            if callback != nil {
                callback!()
            }
        } catch {
            fatalError("Failed to clear messages: \(error)")
        }
    }
    
    func refreshServices(callback: (()->Void)?) {
        Utils.log("AppDelegate.refreshServices", args: nil)
        let context: NSManagedObjectContext = persistentContainer.viewContext
        self.defaultServices.removeAll()
        let entity = NSEntityDescription.entity(forEntityName: "Services", in: context)
        let servicesFetch = NSFetchRequest<NSFetchRequestResult>.init()
        servicesFetch.entity = entity
        do {
            var table = [Services]()
            try table = context.fetch(servicesFetch) as! [Services]
            for row in table {
                self.defaultServices[row.name!] = DefaultService(value: CBUUID.init(string: row.uuid!), isActive: row.is_active, humanName: row.human_name!)
            }
            if callback != nil {
                callback!()
            }
        } catch {
            fatalError("Failed to fetch services: \(error)")
        }
    }
    
    func addServices(services: [String: DefaultService]) {
        Utils.log("AppDelegate.addServices", args: nil)
        let context = persistentContainer.viewContext
        if self.defaultServices.count > 0 {
            clearServices(callback: nil)
            for defaultService in self.defaultServices {
                let servicesInsert = NSEntityDescription.insertNewObject(forEntityName: "Services", into: context)
                servicesInsert.setValue(defaultService.key, forKey: "name")
                servicesInsert.setValue(defaultService.value.value.uuidString, forKey: "uuid")
                servicesInsert.setValue(defaultService.value.isActive, forKey: "is_active")
                servicesInsert.setValue(defaultService.value.humanName, forKey: "human_name")
                do {
                    try context.save()
                } catch {
                    fatalError("Failed to add services: \(error)")
                }
            }
            refreshServices(callback: nil)
        }
        
    }
    
    func clearServices(callback: (()->Void)?) {
        Utils.log("AppDelegate.clearServices", args: nil)
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Services", in: context)
        let servicesFetch = NSFetchRequest<NSFetchRequestResult>.init()
        servicesFetch.entity = entity
        do {
            var table = [Services]()
            try table = context.fetch(servicesFetch) as! [Services]
            for row in table {
                context.delete(row)
            }
            try context.save()
            self.defaultServices.removeAll()
            if callback != nil {
                callback!()
            }
        } catch {
            fatalError("Failed to clear services: \(error)")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AmazfitBipControl")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

