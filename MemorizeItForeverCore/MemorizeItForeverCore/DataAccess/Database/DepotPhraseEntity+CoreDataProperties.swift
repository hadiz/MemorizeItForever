//
//  DepotPhraseEntity+CoreDataProperties.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/12/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//
//

import Foundation
import CoreData


extension DepotPhraseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DepotPhraseEntity> {
        return NSFetchRequest<DepotPhraseEntity>(entityName: "DepotPhraseEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var phrase: String?

}
