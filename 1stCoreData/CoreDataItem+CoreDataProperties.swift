//
//  CoreDataItem+CoreDataProperties.swift
//  1stCoreData
//
//  Created by 王杰 on 2022/8/12.
//
//

import Foundation
import CoreData


extension CoreDataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataItem> {
        return NSFetchRequest<CoreDataItem>(entityName: "CoreDataItem")
    }

    @NSManaged public var itemDate: Date?
    @NSManaged public var itemName: String?

}

extension CoreDataItem : Identifiable {

}
