//
//  ValidatorProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

protocol ValidatorProtocol {
    func validate(_ validatable: ValidatableProtocol, errorMessage:String, by: MITypealiasHelper.validationClosure) -> Bool
    func clear(validatable: ValidatableProtocol)
}
