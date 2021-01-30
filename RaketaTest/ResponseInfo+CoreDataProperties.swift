//
//  ResponseInfo+CoreDataProperties.swift
//  RaketaTest
//
//  Created by mac on 30.01.2021.
//
//

import Foundation
import CoreData


extension ResponseInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResponseInfo> {
        return NSFetchRequest<ResponseInfo>(entityName: "ResponseInfo")
    }

    @NSManaged public var afterString: String?

}

extension ResponseInfo : Identifiable {

}
