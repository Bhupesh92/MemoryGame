//
//  CMDBManager.swift
//  Colour Memory
//
//  Created by Bhupesh on 22/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CMDBManager {
    
    static let shared = CMDBManager()
    private let fatalMessage = "Could not convert delegate to AppDelegate"
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var container : NSPersistentContainer {
        guard let appDelegate = appDelegate else {
            fatalError(fatalMessage)
        }
        return appDelegate.persistentContainer
    }
    
    /// This function will save user info inside DB
    func saveUserInfo(userName: String, score: Int16) -> (isSuccess: Bool, isDuplicate: Bool) {
        guard let appDelegate = appDelegate else {
            fatalError(fatalMessage)
        }
        if let entity =  NSEntityDescription.entity(forEntityName: "CMUser", in: appDelegate.persistentContainer.viewContext) {
            let item = NSManagedObject(entity: entity, insertInto: appDelegate.persistentContainer.viewContext)
            /// IMP: uId should be unique
            item.setValue(userName, forKey: "uId")
            item.setValue(score, forKey: "score")
            return appDelegate.saveContext()
        }
        return (false, false)
    }
    
    /// This function will fetch users info from DB in ascending order
    /// IMP: No pagination is implemented for this. Idealy,  we should handle pagination and fetch 100/200 user at a time for large userbase .
    func fetchUsers() -> [CMUser]? {
        guard let appDelegate = appDelegate else {
            fatalError(fatalMessage)
        }
        let fetchRequest = NSFetchRequest<CMUser>(entityName: "CMUser")
        let sortByScore = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortByScore]
        do {
            let fetchedResults = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print(error.description)
            return nil
        }
    }
    
    /// It will fetch Rank of user.
    /// Known Issue: 1) This algo is not very effieciet if users are in millons. Instead we can use balance binary tree and hash map. 2) If two score are same than rank of user saved first will be greater than later
    
    func fetchUserRank(score: Int16) -> Int? {
        
        guard let appDelegate = appDelegate else {
            fatalError(fatalMessage)
        }
        
        let fetchRequest = NSFetchRequest<CMUser>(entityName: "CMUser")
        
        let sortByScore = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortByScore]
        
        let scorePredicate =  NSPredicate(format: "score >= %i", score)
        fetchRequest.predicate = scorePredicate
        
        do {
            let fetchedResults = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            return fetchedResults.count == 0 ? 1: fetchedResults.count + 1
        } catch let error as NSError {
            print(error.description)
            return nil
        }
        
    }

    
}
