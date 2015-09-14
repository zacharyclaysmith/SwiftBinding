//
//  ThreadUtil.swift
//  SwiftBinding
//
//  Created by Zachary Smith on 6/6/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

internal class ThreadUtil{
  internal class func execute<T>(task:() -> T, completion:((T) -> Void)? = nil){
    let qualityOfServiceClass = QOS_CLASS_BACKGROUND
    let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
    
    dispatch_async(backgroundQueue, {
      let taskResult = task()
      
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        completion?(taskResult)
      })
    })
  }
}