//
//  BindableValue.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation

public class BindableValue<T:Equatable>{
    private var _value:T?
    private var _changeListeners:Dictionary<NSObject, ((T?) -> Void)>
    
    public var value:T?{
        get{
            return _value
        }
        
        set(newValue){
            if(_value != newValue)
            {
                _value = newValue
                
                alertChangeListener()
            }
        }
    }
    
    public init(initialValue:T?){
        _value = initialValue
        _changeListeners = Dictionary<NSObject, ((T?) -> Void)>()
    }

    public func addListener(owner:NSObject, listener:(T?) -> Void, alertNow:Bool = false){
        _changeListeners[owner] = listener
        
        if(alertNow){
            listener(_value)
        }
    }
    
    public func removeListener(owner:NSObject){
        _changeListeners.removeValueForKey(owner)
    }
    
    private func alertChangeListener(){
        for changeListener in _changeListeners.values{
            changeListener(_value)
        }
    }
}