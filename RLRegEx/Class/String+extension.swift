//
//  String+extension.swift
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import Foundation


public extension String {
    
    
    // MARK -
    // MARK substring
    
    internal func substringSafetyFromIndex(fromIndex:Int, length:Int) -> String {
        
        if fromIndex > self.characters.count {
            return ""
        }
        
        var endIndex:Int
        if(length == -1) {
            endIndex = self.characters.count
        } else {
            endIndex = fromIndex + length
            endIndex = min(endIndex, self.characters.count)
        }
        
        return self.substringWithRange(  self.startIndex.advancedBy(fromIndex)..<self.startIndex.advancedBy(endIndex))
    }
    
    internal func substringSafety(fromIndex:Int) -> String {
        return substringSafetyFromIndex(fromIndex, length: -1)
    }
    
    internal func substringWithNSRange(nsrange:NSRange) -> String {
        return substringSafetyFromIndex(nsrange.location, length: nsrange.length)
    }
    
    internal func range() -> Range<String.Index> {
        return  self.startIndex..<self.endIndex
    }
    
    internal func nsrange() -> NSRange {
        return NSMakeRange(0, self.characters.count)
    }
    
    internal func rangeFromNSRange(nsrange:NSRange) -> Range<String.Index> {
        return  self.startIndex.advancedBy(nsrange.location)..<self.startIndex.advancedBy(nsrange.location + nsrange.length)
    }
    

}