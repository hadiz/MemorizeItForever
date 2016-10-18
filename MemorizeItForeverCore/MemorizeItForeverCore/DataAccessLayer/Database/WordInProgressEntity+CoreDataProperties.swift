//
//  WordInProgressEntity+CoreDataProperties.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
 

extension WordInProgressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordInProgressEntity> {
        return NSFetchRequest<WordInProgressEntity>(entityName: "WordInProgressEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var column: Int16
    @NSManaged public var word: WordEntity?

}
