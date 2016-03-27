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

    public func match(pattern:String) throws -> RLMatch?  {
        var error: NSError! = nil
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error1 as NSError {
            error = error1
            regex = nil
        }

        if true && error != nil {
            throw error
        }

        if let nsmatch = regex?.firstMatchInString(self , options: NSMatchingOptions(), range: NSMakeRange(0, self.characters.count)) {
            if nsmatch.range.location != NSNotFound {
                return RLMatch(originalString: self, match: nsmatch)
            }
        }
        return nil
    }

    public func matches(pattern:String, block:(RLMatch) -> Bool) {
        self.matches(pattern, error:nil, block:block)
    }

    public func matches(pattern:String, error:NSErrorPointer, block:(RLMatch) -> Bool) {
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error1 as NSError {
            error.memory = error1
            regex = nil
        }

        if error != nil && error.memory != nil {
            return
        }
        

        regex?.enumerateMatchesInString(self, options: [], range: self.nsrange(), usingBlock: { (checkingResult:NSTextCheckingResult?, matchingFlags:NSMatchingFlags, stop:UnsafeMutablePointer<ObjCBool>) in

            let rlMatch = RLMatch(originalString:self, match:checkingResult)

            let isContinue = block(rlMatch)
            
            let objcBool = ObjCBool.init(!isContinue)
            
            stop.initialize(objcBool)
        })
    }


    // MARK: -
    // MARK: gsub
    

    public func gsub(pattern:String, replacement:String) throws -> String? {
//        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        var error:NSError!
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error1 as NSError {
            error = error1
            print(error)
            regex = nil
        }

        if true && error != nil {
            throw error
        }

        return regex!.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: self.nsrange(), withTemplate: replacement)
    }

}