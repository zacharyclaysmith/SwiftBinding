//
//  PUpdateable.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 2/13/15.
//  Copyright (c) 2015 Zachary Smith. All rights reserved.
//

import Foundation

public protocol PUpdateable{
    func addAnyUpdateListener(owner:NSObject, listener:() -> Void, alertNow:Bool)
    
    func removeAnyUpdateListener(owner:NSObject)
}