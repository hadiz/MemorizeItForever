//
//  NotificationCenterExtension.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/21/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
extension NotificationCenter{
    
   public  func post(_ notificationNameEnum: NotificationEnum, object: Any?){
        self.post(name: Notification.Name(rawValue: notificationNameEnum.rawValue), object: Wrapper(value: object))
    }
    
   public func addObserver(_ observer: AnyObject, selector aSelector: Selector, notificationNameEnum : NotificationEnum?, object anObject: Any?){
        self.addObserver(observer, selector: aSelector, name: (notificationNameEnum?.rawValue).map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
}
