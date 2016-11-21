//
//  ClassWrapper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/28/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

final public class Wrapper<T>{
    let value: T?
    public init(value: T?){
        self.value = value
    }
}
