//
//  String+RegEx.swift
//  RLRegEx
//
//  Created by Muronaka Hiroaki on 2015/06/22.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: -
    // MARK: match
    
    public func match(pattern:String) -> RLMatch?  {
        return self.match(pattern, error:nil)
    }
    
    public func match(pattern:String, error:NSErrorPointer) -> RLMatch?  {
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: error)
        
        if error != nil {
            return nil
        }
        
        if let nsmatch = regex?.firstMatchInString(self , options: NSMatchingOptions.allZeros, range: NSMakeRange(0, count(self))) {
            if nsmatch.range.location != NSNotFound {
                return RLMatch(originalString: self, match: nsmatch)
            }
        }
        return nil
    }
    
    
    // MARK: -
    // MARK: gsub
    public func gsub(pattern:String, replacement:String) -> String? {
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: nil)
        
        return regex?.stringByReplacingMatchesInString(self, options: NSMatchingOptions.allZeros, range: self.nsrange(), withTemplate: replacement)
    }
    
}