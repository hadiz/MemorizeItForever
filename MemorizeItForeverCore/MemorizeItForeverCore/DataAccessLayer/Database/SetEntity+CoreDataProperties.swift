//
//  SetEntity+CoreDataProperties.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData

extension SetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetEntity> {
        return NSFetchRequest<SetEntity>(entityName: "SetEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var words: WordEntity?

}
