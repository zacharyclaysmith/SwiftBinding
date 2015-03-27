//
//  BindableValue.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Zachary Smith. All rights reserved.
//

import Foundation

public class BindableValue<ValueType>:PUpdateable{
    private var _value:ValueType
    private var _changeListeners:[NSObject: (ValueType) -> Void]
    private var _anyUpdateListeners:[NSObject: () -> Void]
    
    public var value:ValueType{
        get{
            return _value
        }
        
        set(newValue){
            _value = newValue
            
            alertChangeListeners()
            alertAnyUpdateListeners()
        }
    }
    
    //EXPL: Shorthand wrapper for the value property
    public var v:ValueType{get{return self.value}set(value){self.value = value}}
    
    public init(value:ValueType){
        _value = value
        _changeListeners = Dictionary<NSObject, ((ValueType) -> Void)>()
        _anyUpdateListeners = Dictionary<NSObject, (() -> Void)>()
    }

    public func addListener(owner:NSObject, listener:(ValueType) -> Void, alertNow:Bool = false){
        //test.setObject(listener, forKey: owner)
        _changeListeners[owner] = listener
        
        if(alertNow){
            listener(_value)
        }
    }
    
    public func removeListener(owner:NSObject){
        _changeListeners.removeValueForKey(owner)
    }
    
    internal func alertChangeListeners(){
        for changeListener in _changeListeners.values{
            changeListener(_value)
        }
    }
    
    internal func alertAnyUpdateListeners(){
        for anyUpdateListener in _anyUpdateListeners.values{
            anyUpdateListener()
        }
    }
    
    public func addAnyUpdateListener(owner:NSObject, listener:() -> Void, alertNow:Bool){
        _anyUpdateListeners[owner] = listener
        
        if(alertNow){
            listener()
        }
    }
    
    public func removeAnyUpdateListener(owner:NSObject){
        _anyUpdateListeners.removeValueForKey(owner)
    }
}