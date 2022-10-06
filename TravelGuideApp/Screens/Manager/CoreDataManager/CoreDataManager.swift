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
      
      //used to pull data from core data
    func getCoreData(_ entityName: String, onSuccess: @escaping ([NSFetchRequestResult]) -> (), onError:(String?) -> ()){
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          fetchRequest.returnsObjectsAsFaults = false
          do{
              let results = try context.fetch(fetchRequest)
              //data from core data
              if results.count > 0{
                  onSuccess(results)
              }else{
                  onError("GetCoreData result not found!")
              }

          }
          catch {
              print("GetCoreData Error")
              onError("GetCoreData Error")
          }
      }
    /*
    func setCoreData(_ entityName: String, onSuccess: @escaping ([NSFetchRequestResult]) -> (), onError:(String?) -> ()){
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          fetchRequest.returnsObjectsAsFaults = false
          do{
              let results = try context.fetch(fetchRequest)
              //data from core data
              if results.count > 0{
                  onSuccess(results)
              }else{
                  onError("GetCoreData result not found!")
              }

          }
          catch {
              print("GetCoreData Error")
              onError("GetCoreData Error")
          }
      }*/
}
