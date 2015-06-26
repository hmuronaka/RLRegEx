//
//  RLMatch.swift
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

public class RLMatch: NSObject {
    
    let originalString:String
    var match:NSTextCheckingResult!
    
    var count:Int {
        get {
            if let result = match {
                return result.numberOfRanges
            } else {
                return 0
            }
        }
    }
    
    init(originalString:String, match: NSTextCheckingResult!) {
        self.originalString = originalString
        self.match = match
        super.init()
    }
    
    public subscript(index:Int) -> String {
        var result:String = ""
        
        if index < count {
            if let result = match {
                let range = result.rangeAtIndex(index)
                return self.originalString.substringWithNSRange(range)
            }
        }
        
        return result
    }
    
}
