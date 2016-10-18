//
//  WordHistoryEntity+CoreDataProperties.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData 

extension WordHistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordHistoryEntity> {
        return NSFetchRequest<WordHistoryEntity>(entityName: "WordHistoryEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var failureCount: Int32
    @NSManaged public var columnNo: Int16
    @NSManaged public var word: WordEntity?

}
