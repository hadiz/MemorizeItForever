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
        
        defaultContainer.register(WordManagerProtocol.self, name: "WithoutHistoryDataAccess"){ r in
            WordManager(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!)
        }
        
        defaultContainer.register(WordManagerProtocol.self, name: "WithHistoryDataAccess"){ r in
            WordManager(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!, wordHistoryDataAccess: r.resolve(WordHistoryDataAccessProtocol.self))
        }
        
        defaultContainer.storyboardInitCompleted(TabBarController.self) { r, c in
            c.setManager = r.resolve(SetManagerProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(MemorizeItViewController.self) { r, c in
            c.changeSetViewController = r.resolve(ChangeSetViewController.self)
            c.addPhraseViewController = r.resolve(AddPhraseViewController.self)
            c.reviewPhraseViewController = r.resolve(ReviewPhraseViewController.self)
            c.takeTestViewController = r.resolve(TakeTestViewController.self)
            c.phraseViewController = r.resolve(PhraseViewController.self)
        }
        
        defaultContainer.storyboardInitCompleted(SetViewController.self) { r, c in
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
            }.inObjectScope(.transient)
        
        defaultContainer.register(AddPhraseViewController.self) { r in
            let controller = AddPhraseViewController()
            controller.validator = r.resolve(ValidatorProtocol.self)
            controller.wordManager = r.resolve(WordManagerProtocol.self, name: "WithoutHistoryDataAccess")
            return controller
            }.inObjectScope(.transient)
        
        defaultContainer.register(ReviewPhraseViewController.self) { r in
            let controller = ReviewPhraseViewController()
            controller.wordFlowManager = r.resolve(WordFlowManagerProtocol.self)
            return controller
            }.inObjectScope(.transient)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "SetTableDataSource") { r in
            SetTableDataSource(setManager: r.resolve(SetManagerProtocol.self))
            }.inObjectScope(.transient)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource") { r in
            ChangeSetTableDataSource(setManager: r.resolve(SetManagerProtocol.self))
            }.inObjectScope(.transient)
        
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
            }.inObjectScope(.transient)
        
        defaultContainer.register(WordFlowManagerProtocol.self){ r in
            WordFlowManager(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!, wordInProgressDataAccess: r.resolve(WordInProgressDataAccessProtocol.self)!, wordHistoryDataAccess: r.resolve(WordHistoryDataAccessProtocol.self)!)
        }
        
        defaultContainer.register(PhraseViewController.self) { r in
            let controller = PhraseViewController()
            controller.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource")
            controller.wordManager = r.resolve(WordManagerProtocol.self, name: "WithoutHistoryDataAccess")
            controller.phraseHistoryViewController = r.resolve(PhraseHistoryViewController.self)
            return controller
            }.inObjectScope(.transient)
        
        defaultContainer.register(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource"){ r in
            PhraseTableDataSource(wordManager: r.resolve(WordManagerProtocol.self, name: "WithoutHistoryDataAccess"))
            }.inObjectScope(.transient)
        
        defaultContainer.register(PhraseHistoryViewController.self){ r in
            let controller = PhraseHistoryViewController()
            controller.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseHistoryTableDataSource")
            controller.wordManager = r.resolve(WordManagerProtocol.self, name: "WithHistoryDataAccess")
            return controller
            }.inObjectScope(.transient)
        
        defaultContainer.register(PhraseTableDataSourceProtocol.self, name: "PhraseHistoryTableDataSource"){ r in
            PhraseHistoryTableDataSource(wordManager: nil)
            }.inObjectScope(.transient)
    }
}
