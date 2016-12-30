//
//  ViewControllerFactory.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/30/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import SwinjectStoryboard

class ViewControllerFactory: ViewControllerFactoryProtocol {

    func changeSetViewControllerFactory() -> ChangeSetViewController {
        return SwinjectStoryboard.defaultContainer.resolve(ChangeSetViewController.self)!
    }
    
    func addPhraseViewControllerFactory() -> AddPhraseViewController {
        return SwinjectStoryboard.defaultContainer.resolve(AddPhraseViewController.self)!
    }
    
    func reviewPhraseViewControllerFactory() -> ReviewPhraseViewController {
        return SwinjectStoryboard.defaultContainer.resolve(ReviewPhraseViewController.self)!
    }
    
    func takeTestViewControllerFactory() -> TakeTestViewController {
        return SwinjectStoryboard.defaultContainer.resolve(TakeTestViewController.self)!
    }
    
    func phraseViewControllerFactory() -> PhraseViewController {
        return SwinjectStoryboard.defaultContainer.resolve(PhraseViewController.self)!
    }

    func setItemViewControllerFactory() -> SetItemViewController {
        return SwinjectStoryboard.defaultContainer.resolve(SetItemViewController.self)!
    }
    
    func phraseHistoryViewControllerFactory() -> PhraseHistoryViewController {
        return SwinjectStoryboard.defaultContainer.resolve(PhraseHistoryViewController.self)!
    }
}
