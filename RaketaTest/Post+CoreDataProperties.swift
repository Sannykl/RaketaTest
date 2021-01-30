//
//  Post+CoreDataProperties.swift
//  RaketaTest
//
//  Created by mac on 30.01.2021.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var createdAt: Int64
    @NSManaged public var comments: Int16
    @NSManaged public var sortPosition: Int16

}

extension Post : Identifiable {

}
