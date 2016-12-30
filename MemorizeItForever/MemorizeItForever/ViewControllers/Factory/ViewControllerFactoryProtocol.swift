//
//  ViewControllerFactoryProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/30/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

protocol ViewControllerFactoryProtocol {
    func changeSetViewControllerFactory() -> ChangeSetViewController
    func addPhraseViewControllerFactory() -> AddPhraseViewController
    func reviewPhraseViewControllerFactory() -> ReviewPhraseViewController
    func takeTestViewControllerFactory() -> TakeTestViewController
    func phraseViewControllerFactory() -> PhraseViewController
    func setItemViewControllerFactory() -> SetItemViewController
    func phraseHistoryViewControllerFactory() -> PhraseHistoryViewController
}
