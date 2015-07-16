//
//  CalculatedArray.swift
//  SwiftBinding
//
//  Created by Zachary Smith on 3/26/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

public extension BindableArray{
    public func transform<ValueType>(calculator: () -> [ValueType]) -> CalculatedArray<ValueType>{
        return CalculatedArray(boundValues: [self], calculator: calculator)
    }
  
    public func filter<ValueType>(calculator: () -> [ValueType]) -> CalculatedArray<ValueType>{
      return CalculatedArray(boundValues: [self], calculator: calculator)
    }
  
    public func filter<ValueType>(filterValue: PUpdateable, calculator: () -> [ValueType]) -> CalculatedArray<ValueType>{
        return CalculatedArray(boundValues: [self, filterValue], calculator: calculator)
    }
    
    public func filter<ValueType>(filterValues: [PUpdateable], calculator: () -> [ValueType]) -> CalculatedArray<ValueType>{
        return CalculatedArray(boundValues: [self] + filterValues, calculator: calculator)
    }
  
  public func map<ValueType>(mapFunction: (T) -> ValueType) -> CalculatedArray<ValueType>{
    return CalculatedArray(boundValues: [self], calculator: {
      return self.internalArray.map({mapFunction($0)})
    })
  }
  
  public func map<ValueType, NewValueType>(filterValue: PUpdateable, mapFunction: (T) -> NewValueType) -> CalculatedArray<NewValueType>{
    return CalculatedArray(boundValues: [self, filterValue], calculator: {
      return self.internalArray.map({mapFunction($0)})
    })
  }
  
  public func map<ValueType, NewValueType>(filterValues: [PUpdateable], mapFunction: (T) -> NewValueType) -> CalculatedArray<NewValueType>{
    return CalculatedArray(boundValues: [self] + filterValues, calculator: {
      return self.internalArray.map({mapFunction($0)})
    })
  }
}

public class CalculatedArray<ValueType>:BindableArray<ValueType>{
    private let _listenerOwner:NSObject = NSObject()
    
    private func calculateValue(){
        self.internalArray = calculator()
    }
    
    public var calculator:() -> [ValueType]
    
    private var _boundValues:[PUpdateable]
    
    //TODO: fine-tune updates for PBindableCollections
    public init(boundValues:[PUpdateable], calculator:() -> [ValueType]){
        _boundValues = boundValues
        self.calculator = calculator
        
        super.init(value:calculator())
        
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