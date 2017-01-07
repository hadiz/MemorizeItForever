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
        
        registerContext()
        
        defaultContainer.storyboardInitCompleted(TabBarController.self) { r, c in
            c.setService = r.resolve(SetServiceProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(MemorizeItViewController.self) { r, c in
            c.viewControllerFactory = r.resolve(ViewControllerFactoryProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(SetViewController.self) { r, c in
            c.setService = r.resolve(SetServiceProtocol.self)
            c.viewControllerFactory = r.resolve(ViewControllerFactoryProtocol.self)
            c.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "SetTableDataSource")
        }
        
        defaultContainer.register(SetItemViewController.self) { r in
            let controller = SetItemViewController()
            controller.setService = r.resolve(SetServiceProtocol.self)
            return controller
        }
        
        defaultContainer.register(ChangeSetViewController.self) { r in
            let controller = ChangeSetViewController()
            controller.setService = r.resolve(SetServiceProtocol.self)
            controller.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource")
            return controller
            }.inObjectScope(.transient)
        
        defaultContainer.register(AddPhraseViewController.self) { r in
            let controller = AddPhraseViewController()
            controller.validator = r.resolve(ValidatorProtocol.self)
            controller.wordService = r.resolve(WordServiceProtocol.self)
            return controller
            }.initCompleted({ (r, controller) in
                controller.coordinatorDelegate = r.resolve(UIViewCoordinatorDelegate.self, name: "AddPhrase")
            }).inObjectScope(.weak)
        
        defaultContainer.register(ReviewPhraseViewController.self) { r in
            let controller = ReviewPhraseViewController()
            controller.wordFlowService = r.resolve(WordFlowServiceProtocol.self)
            return controller
            }.inObjectScope(.weak)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "SetTableDataSource") { r in
            SetTableDataSource(setService: r.resolve(SetServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource") { r in
            ChangeSetTableDataSource(setService: r.resolve(SetServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.register(ValidatorProtocol.self){ r in
            Validator()
        }
        
        defaultContainer.register(TakeTestViewController.self) { r in
            let controller = TakeTestViewController()
            controller.wordFlowService = r.resolve(WordFlowServiceProtocol.self)
            return controller
            }.inObjectScope(.weak)

        
        defaultContainer.register(PhraseViewController.self) { r in
            let controller = PhraseViewController()
            controller.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource")
            controller.wordService = r.resolve(WordServiceProtocol.self)
            controller.viewControllerFactory = r.resolve(ViewControllerFactoryProtocol.self)
            return controller
            }.inObjectScope(.weak)
        
        defaultContainer.register(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource"){ r in
            PhraseTableDataSource(wordService: r.resolve(WordServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.register(PhraseHistoryViewController.self){ r in
            let controller = PhraseHistoryViewController()
            controller.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseHistoryTableDataSource")
            controller.wordService = r.resolve(WordServiceProtocol.self)
            return controller
            }.initCompleted({ (r, controller) in
                controller.coordinatorDelegate = r.resolve(UIViewCoordinatorDelegate.self, name: "PhraseHistory")
            }).inObjectScope(.weak)
        
        defaultContainer.register(PhraseTableDataSourceProtocol.self, name: "PhraseHistoryTableDataSource"){ r in
            PhraseHistoryTableDataSource(wordService: nil)
            }.inObjectScope(.weak)
        
        defaultContainer.register(ServiceFactoryProtocol.self, name: "SetServiceFactory"){ r in
            SetServiceFactory()
        }
        
        defaultContainer.register(ServiceFactoryProtocol.self, name: "WordServiceFactory"){ r in
            WordServiceFactory()
        }
        
        defaultContainer.register(ServiceFactoryProtocol.self, name: "WordFlowServiceFactory"){ r in
            WordFlowServiceFactory()
        }
        
        defaultContainer.register(SetServiceProtocol.self){ r in
            let setServiceFactory = r.resolve(ServiceFactoryProtocol.self, name: "SetServiceFactory")!
            let setService: SetService = setServiceFactory.create()
            return setService
        }
        
        defaultContainer.register(WordServiceProtocol.self){ r in
            let wordServiceFactory = r.resolve(ServiceFactoryProtocol.self, name: "WordServiceFactory")!
            let wordService: WordService = wordServiceFactory.create()
            return wordService
        }
        
        defaultContainer.register(WordFlowServiceProtocol.self){ r in
            let wordFlowServiceFactory = r.resolve(ServiceFactoryProtocol.self, name: "WordFlowServiceFactory")!
            let wordFlowService: WordFlowService = wordFlowServiceFactory.create()
            return wordFlowService
        }
        
        defaultContainer.register(ViewControllerFactoryProtocol.self){ r in
            ViewControllerFactory()
        }
        
        
        defaultContainer.register(UIViewCoordinatorDelegate.self,name: "AddPhrase"){ r in
            AddPhraseViewCoordinator(viewController: r.resolve(AddPhraseViewController.self)!)
        }
        
        defaultContainer.register(UIViewCoordinatorDelegate.self,name: "PhraseHistory"){ r in
            PhraseHistoryViewCoordinator(viewController: r.resolve(PhraseHistoryViewController.self)!)
        }
    }
    
    private class func registerContext(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context: NSManagedObjectContext
        if #available(iOS 10.0, *) {
            context =  appDelegate.persistentContainer.viewContext
        } else {
            context = appDelegate.managedObjectContext
        }
        ContextHelper.shared.setContext(context: context)
        
    }
    
}
