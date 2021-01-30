//
//  CoreDataManager.swift
//  RaketaTest
//
//  Created by mac on 30.01.2021.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static func hasData() -> Bool {
        return posts().count > 0
    }
    
    static func saveResponseModel(_ model: ResponseModel) {
        let context = currentContext()
        
        if let responseInfo = responseInfo() {
            responseInfo.afterString = model.data.after
        } else {
            let responseInfo = NSEntityDescription.insertNewObject(forEntityName: "ResponseInfo", into: context) as! ResponseInfo
            responseInfo.afterString = model.data.after
        }
        saveContext(context)
    }
    
    static func savePosts(_ posts: [PostModel]) {
        let context = currentContext()
        var position = self.posts().count
        for post in posts {
            let managedModel = NSEntityDescription.insertNewObject(forEntityName: "Post", into: context) as! Post
            managedModel.title = post.data.title
            managedModel.author = post.data.author
            managedModel.comments = Int16(post.data.commentsCount)
            managedModel.createdAt = Int64(post.data.createdAt)
            managedModel.imageURL = post.data.imageURL
            managedModel.thumbnail = post.data.thumbnail
            managedModel.sortPosition = Int16(position)
            position += 1
        }
        saveContext(context)
    }
    
    static func afterParameter() -> String? {
        if let responseInfo = responseInfo() {
            return responseInfo.afterString
        }
        return nil
    }
    
    static func postModels() -> [PostModel] {
        var models: [PostModel] = []
        let managedObjects = posts()
        for managedObject in managedObjects {
            let model = PostModel(managedObject: managedObject)
            models.append(model)
        }
        return models
    }
    
    static func clearData() {
        clearPosts()
        clearResponseInfo()
    }
}

private extension CoreDataManager {
    
    static func responseInfo() -> ResponseInfo? {
        let context = currentContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ResponseInfo")
        do {
            let result = try context.fetch(request)
            return result.first as? ResponseInfo
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func posts() -> [Post] {
        let context = currentContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        let sortDescriptor = NSSortDescriptor(key: "sortPosition", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let result = try context.fetch(request)
            return result as? [Post] ?? []
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return []
    }
    
    static func clearPosts() {
        let context = currentContext()
        let postObjects = posts()
        for post in postObjects {
            context.delete(post)
        }
        saveContext(context)
    }
    
    
    static func clearResponseInfo() {
        let context = currentContext()
        guard let info = responseInfo() else { return }
        context.delete(info)
        saveContext(context)
    }
    
    static func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    static func currentContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
