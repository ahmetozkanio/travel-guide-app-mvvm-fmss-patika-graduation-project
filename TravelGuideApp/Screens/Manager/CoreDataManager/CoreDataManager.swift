//
//  CoreDataManager.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 6.10.2022.
//

import CoreData
import UIKit.UIApplication

// MARK: - CoreData Manager
final class CoreDataManager{
    static let shared: CoreDataManager = CoreDataManager()
}
extension CoreDataManager{
    
    // CoreData the process of get data based on entityName with this generic func
    func getCoreData(_ entityName: String, onSuccess: @escaping ([NSFetchRequestResult]) -> (), onError:(String?) -> ()){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                onSuccess(results)
            }else{
                onSuccess([])
                onError("GetCoreData result not found!")
            }
        }
        catch {
            print("GetCoreData Error")
            onError("GetCoreData Error")
        }
    }
    // Saved of BookmarkItem entity
    func setCoreData(_ bookmarkItem: BookmarksEntity?,_ entityName: String, onSuccess: @escaping (Bool) -> (), onError:(String?) -> ()){
        guard let item = bookmarkItem else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let setData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        setData.setValue(UUID(), forKey: "id")
        setData.setValue(item.title, forKey: "title")
        setData.setValue(item.subTitle, forKey: "subTitle")
        setData.setValue(item.content, forKey: "content")
        setData.setValue(item.image, forKey: "image")
        do{
            try context.save()
            onSuccess(true)
        } catch{
            onError("Set CoreData error")
            print("Set CoreData error")
        }
    }
    // Delete of BookmarkItem entity
    func deleteBookmark(_ bookmarkItem: BookmarksEntity?,_ entityName: String, onSuccess: @escaping (Bool) -> ()){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if result.value(forKey: "title") as? String == bookmarkItem?.title{
                    context.delete(result)
                    try context.save()
                    onSuccess(true)
                    NotificationCenter.default.post(name: NSNotification.Name("reloadBookmarksData"), object: nil)
                    return
                }
            }
            onSuccess(false)
        }catch{
            onSuccess(false)
        }
    }
}


