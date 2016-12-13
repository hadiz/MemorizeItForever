//
//  UIViewExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

extension UIView{
    func mockMakeASuccessToast(){
        objc_setAssociatedObject(self, &key, UIViewEnum.successToast, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func mockMakeAFailureToast(){
        objc_setAssociatedObject(self, &key, UIViewEnum.failureToast, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
