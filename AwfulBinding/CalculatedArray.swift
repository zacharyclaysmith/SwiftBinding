//
//  CalculatedArray.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 3/26/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

public extension BindableArray{
    public func transform<ValueType>(calculator:([PUpdateable]) -> [ValueType]) -> CalculatedArray<ValueType>{
        return CalculatedArray(boundValues: [self], calculator: calculator)
    }
}

public class CalculatedArray<ValueType>:BindableArray<ValueType>{
    private let _listenerOwner:NSObject = NSObject()
    
    private func calculateValue(){
        self.internalArray = calculator(_boundValues)
    }
    
    public var calculator:([PUpdateable]) -> [ValueType]
    
    private var _boundValues:[PUpdateable]
    
    //TODO: fine-tune updates for PBindableCollections
    public init(boundValues:[PUpdateable], calculator:([PUpdateable]) -> [ValueType]){
        _boundValues = boundValues
        self.calculator = calculator
        
        super.init(internalArray:calculator(boundValues))
        
        for boundValue in boundValues{
            boundValue.addAnyUpdateListener(_listenerOwner, listener: boundValueUpdated, alertNow: false)
        }
    }
    
    deinit{
        for boundValue in _boundValues{
            boundValue.removeAnyUpdateListener(_listenerOwner)
        }
    }
    
    private func boundValueUpdated(){
        calculateValue()
    }
}