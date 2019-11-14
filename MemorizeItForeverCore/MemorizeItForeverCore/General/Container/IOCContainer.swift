//
//  IOCContainer.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 12/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Swinject
import BaseLocalDataAccess

let iocContainer = Container() { c in
    c.register(SetDataAccessProtocol.self){ r in
        SetDataAccess(genericDataAccess: r.resolve(GenericDataAccess<SetEntity>.self)!)
    }
    
    c.register(WordDataAccessProtocol.self){ r in
        WordDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!,setDataAccess: r.resolve(GenericDataAccess<SetEntity>.self)!)
    }
    
    c.register(WordInProgressDataAccessProtocol.self){ r in
        WordInProgressDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordInProgressEntity>.self)!, wordDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!)
    }
    
    c.register(WordHistoryDataAccessProtocol.self){ r in
        WordHistoryDataAccess(genericDataAccess: r.resolve(GenericDataAccess<WordHistoryEntity>.self)!, wordDataAccess: r.resolve(GenericDataAccess<WordEntity>.self)!)
    }
    
    c.register(GenericDataAccess<SetEntity>.self){ r in
        GenericDataAccess<SetEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
    }
    
    c.register(GenericDataAccess<WordEntity>.self){ r in
        GenericDataAccess<WordEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
    }
    
    c.register(GenericDataAccess<WordInProgressEntity>.self){ r in
        GenericDataAccess<WordInProgressEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
    }
    
    c.register(GenericDataAccess<WordHistoryEntity>.self){ r in
        GenericDataAccess<WordHistoryEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
    }
    
    c.register(WordFlowServiceProtocol.self){ r in
        WordFlowService(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!, wordInProgressDataAccess: r.resolve(WordInProgressDataAccessProtocol.self)!, wordHistoryDataAccess: r.resolve(WordHistoryDataAccessProtocol.self)!)
    }
    
    c.register(SetServiceProtocol.self){ r in
        SetService(dataAccess: r.resolve(SetDataAccessProtocol.self)!)
    }
    
    c.register(WordServiceProtocol.self){ r in
        WordService(wordDataAccess: r.resolve(WordDataAccessProtocol.self)!, wordHistoryDataAccess: r.resolve(WordHistoryDataAccessProtocol.self))
    }
    
    c.register(ManagedObjectContextProtocol.self){ r in
         BaseManagedObjectContext()
        }.inObjectScope(ObjectScope.container)
    
    c.register(DepotPhraseDataAccessProtocol.self){ r in
        DepotPhraseDataAccess(genericDataAccess: r.resolve(GenericDataAccess<DepotPhraseEntity>.self)!)
    }
    
    c.register(GenericDataAccess<DepotPhraseEntity>.self){ r in
        GenericDataAccess<DepotPhraseEntity>(context: r.resolve(ManagedObjectContextProtocol.self)!)
    }

    c.register(DepotPhraseServiceProtocol.self){ r in
        DepotPhraseService(dataAccess: r.resolve(DepotPhraseDataAccessProtocol.self)!)
    }
}
