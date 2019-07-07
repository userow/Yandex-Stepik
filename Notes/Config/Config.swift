//
//  Config.swift
//  Notes
//
//  Created by Paul Vasilenko on 7/7/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit

class Config {
    static var isQA: Bool {
        var isqa = false
        
        #if QA
        isqa = true
        #endif
        
        return isqa
    }
    
    static var isDEBUG: Bool {
        var isd = false
        
        #if DEBUG
        isd = true
        #endif
        
        return isd
    }
    
    static var isRELEASE: Bool {
        var isr = true
        
        if Config.isQA || Config.isDEBUG {
            isr = false
        }
        
        return isr
    }
    
    static var barTintColor: UIColor? {
        var col: UIColor? = nil
        
        if (Config.isQA) {
            col = .yellow
        }
        
        if (Config.isDEBUG) {
            col = .red
        }
        
        return col
    }
    
    static var suffix: String? {
        var suff: String? = nil
        
        if (Config.isQA) {
            suff = " QA"
        }
        
        if (Config.isDEBUG) {
            suff = " DEBUG"
        }
        
        return suff
    }
}

