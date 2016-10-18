//
//  NotificationCenterExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/17/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import  MemorizeItForeverCore
extension NotificationCenter{
    
    func postNotification(_ notificationNameEnum: NotificationEnum, object: AnyObject?){
        self.post(name: Notification.Name(rawValue: notificationNameEnum.rawValue), object: Wrapper(wrappedValue: object))
    }
    
    func addObserver(_ observer: AnyObject, selector aSelector: Selector, notificationNameEnum : NotificationEnum?, object anObject: AnyObject?){
        self.addObserver(observer, selector: aSelector, name: (notificationNameEnum?.rawValue).map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
}
