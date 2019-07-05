//
//  Note.swift
//  Yandex-Course-On-Stepik
//
//  Created by Paul Vasilenko on 6/28/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit

struct Note {
    enum Importance: String {
        case unimportant
        case normal
        case important
    }
    
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    init(uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = .white,
         importance: Importance,
         selfDestructionDate: Date? = nil) {
        self.uid = uid
        
        self.title = title
        self.content = content
        self.importance = importance
        self.color = color
        
        self.selfDestructionDate = selfDestructionDate
    }
    
}
