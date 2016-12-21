//
//  WordEntity+CoreDataProperties.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
 

extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var meaning: String?
    @NSManaged public var order: Int32
    @NSManaged public var phrase: String?
    @NSManaged public var status: Int16
    @NSManaged public var set: SetEntity?

}
