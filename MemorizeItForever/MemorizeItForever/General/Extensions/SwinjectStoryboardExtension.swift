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
     
        defaultContainer.storyboardInitCompleted(SetViewController.self) { r, c in
            c.setService = r.resolve(SetServiceProtocol.self)
            c.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "SetTableDataSource")
        }
        
        defaultContainer.storyboardInitCompleted(SetItemViewController.self) { r, c in
            c.setService = r.resolve(SetServiceProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(ChangeSetViewController.self) { r, c in
            c.setService = r.resolve(SetServiceProtocol.self)
            c.dataSource = r.resolve(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource")
        }
        
        defaultContainer.storyboardInitCompleted(AddPhraseViewController.self) { r, c in
            c.wordService = r.resolve(WordServiceProtocol.self)
            c.validator = r.resolve(ValidatorProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(ReviewPhraseViewController.self) { r, c in
            c.wordFlowService = r.resolve(WordFlowServiceProtocol.self)
        }
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "SetTableDataSource") { r in
            SetTableDataSource(setService: r.resolve(SetServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.register(SetTableDataSourceProtocol.self, name: "ChangeSetTableDataSource") { r in
            ChangeSetTableDataSource(setService: r.resolve(SetServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.register(ValidatorProtocol.self){ r in
            Validator()
        }
        
        defaultContainer.storyboardInitCompleted(TakeTestViewController.self) { r, c in
            c.wordFlowService = r.resolve(WordFlowServiceProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(PhraseViewController.self) { r, c in
            c.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource")
            c.wordService = r.resolve(WordServiceProtocol.self)
        }

        defaultContainer.register(PhraseTableDataSourceProtocol.self, name: "PhraseTableDataSource"){ r in
            PhraseTableDataSource(wordService: r.resolve(WordServiceProtocol.self))
            }.inObjectScope(.weak)
        
        defaultContainer.storyboardInitCompleted(PhraseHistoryViewController.self) { r, c in
            c.dataSource = r.resolve(PhraseTableDataSourceProtocol.self, name: "PhraseHistoryTableDataSource")
            c.wordService = r.resolve(WordServiceProtocol.self)
        }
        
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
