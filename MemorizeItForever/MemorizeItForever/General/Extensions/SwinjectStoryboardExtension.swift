//
//  SwinjectStoryboardExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/12/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import MemorizeItForeverCore
import BaseLocalDataAccess
import CoreData

extension SwinjectStoryboard {
    class func setup() {
        
        defaultContainer.register(ManagedObjectContextProtocol.self){ r in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            var context: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                context =  appDelegate.persistentContainer.viewContext
            } else {
                context = appDelegate.managedObjectContext
            }
            
            let managedObjectContext = BaseManagedObjectContext(context: context)
            return managedObjectContext
            }.inObjectScope(ObjectScope.container)
        
        defaultContainer.register(SetDataAccessProtocol.self){ r in
            SetDataAccess(genericDataAccess: r.resolve(GenericDataAccess<SetEntity>.self)!)
        }
        
        defaultContainer.register(WordDataAccessProtocol.self){ r in
            WordDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!,setDataAccess: r.resolve(GenericDataAccess<SetEntity>.self)!)
        }
        
        defaultContainer.register(WordInProgressDataAccessProtocol.self){ r in
            WordInProgressDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordInProgressEntity>.self)!, wordDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!)
        }
        
        defaultContainer.register(WordHistoryDataAccessProtocol.self){ r in
            WordHistoryDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordHistoryEntity>.self)!, wordDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!)
        }
        
        defaultContainer.register(SetManagerProtocol.self){ r in
            SetManager(dataAccess: r.resolve(SetDataAccessProtocol.self)!)
        }
        
        defaultContainer.register(WordManagerProtocol.self){ r in
            WordManager(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!)
        }
        
        defaultContainer.registerForStoryboard(TabBarController.self) { r, c in
            c.setManager = r.resolve(SetManagerProtocol.self)
        }
        
        defaultContainer.registerForStoryboard(MemorizeItViewController.self) { r, c in
            c.changeSetViewController = r.resolve(ChangeSetViewController.self)
            c.addPhraseViewController = r.resolve(AddPhraseViewController.self)
            c.reviewPhraseViewController = r.resolve(ReviewPhraseViewController.self)
            c.takeTestViewController = r.resolve(TakeTestViewController.self)
        }
        
        defaultContainer.registerForStoryboard(SetViewController.self) { r, c in
            c.setManager = r.resolve(SetManagerProtocol.self)
            c.setItemViewController = r.resolve(SetItemViewController.self)
            c.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "SetTableDataSource")
        }
        
        defaultContainer.register(SetItemViewController.self) { r in
            let controller = SetItemViewController()
            controller.setManager = r.resolve(SetManagerProtocol.self)
            return controller
        }
        
        defaultContainer.register(ChangeSetViewController.self) { r in
            let controller = ChangeSetViewController()
            controller.setManager = r.resolve(SetManagerProtocol.self)
            controller.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource")
            return controller
            }.inObjectScope(.none)
        
        defaultContainer.register(AddPhraseViewController.self) { r in
            let controller = AddPhraseViewController()
            controller.validator = r.resolve(ValidatorProtocol.self)
            controller.wordManager = r.resolve(WordManagerProtocol.self)
            return controller
            }.inObjectScope(.none)
        
        defaultContainer.register(ReviewPhraseViewController.self) { r in
            let controller = ReviewPhraseViewController()
            controller.wordFlowManager = r.resolve(WordFlowManagerProtocol.self)
            return controller
            }.inObjectScope(.none)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "SetTableDataSource") { r in
            SetTableDataSource(setManager: r.resolve(SetManagerProtocol.self))
        }.inObjectScope(.none)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource") { r in
            ChangeSetTableDataSource(setManager: r.resolve(SetManagerProtocol.self))
        }.inObjectScope(.none)
        
        defaultContainer.register(ValidatorProtocol.self){ r in
            Validator()
        }
        
        defaultContainer.register(GenericDataAccess<SetEntity>.self){ r in
            GenericDataAccess<SetEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
        }
        
        defaultContainer.register(GenericDataAccess<WordEntity>.self){ r in
            GenericDataAccess<WordEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
        }
        
        defaultContainer.register(GenericDataAccess<WordInProgressEntity>.self){ r in
            GenericDataAccess<WordInProgressEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
        }
        
        defaultContainer.register(GenericDataAccess<WordHistoryEntity>.self){ r in
            GenericDataAccess<WordHistoryEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
        }
        
        defaultContainer.register(TakeTestViewController.self) { r in
            let controller = TakeTestViewController()
            controller.wordFlowManager = r.resolve(WordFlowManagerProtocol.self)
            return controller
        }.inObjectScope(.none)
        
        defaultContainer.register(WordFlowManagerProtocol.self){ r in
            WordFlowManager(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!, wordInProgressDataAccess: r.resolve(WordInProgressDataAccessProtocol.self)!, wordHistoryDataAccess: r.resolve(WordHistoryDataAccessProtocol.self)!)
        }
    }
}
