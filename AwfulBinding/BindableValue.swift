//
//  BindableValue.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation

public class BindableValue<ValueType:Any>{
    private var _value:ValueType?
    private var _changeListeners:Dictionary<NSObject, ((ValueType?) -> Void)>
    
    public var value:ValueType?{
        get{
            return _value
        }
        
        set(newValue){
            _value = newValue
            
            alertChangeListener()
        }
    }
    
    public init(initialValue:ValueType?){
        _value = initialValue
        _changeListeners = Dictionary<NSObject, ((ValueType?) -> Void)>()
    }

    public func addListener(owner:NSObject, listener:(ValueType?) -> Void, alertNow:Bool = false){
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
    
    public var labelFunction:((value:ValueType?) -> String)?
    
    public var label:String?{
        return labelFunction?(value: value)
    }
}