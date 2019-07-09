//
//  NoteExtension.swift
//  Yandex-Course-On-Stepik
//
//  Created by Paul Vasilenko on 6/30/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit

/***
 Создайте файл NoteExtension.swift. В нём вам предстоит реализовать код расширения.
 Реализуйте расширение структуры Note, которое:
 Содержит функцию для разбора json: static func parse(json: [String: Any]) -> Note?.
 Содержит вычислимое свойство для формирования json: var json: [String: Any].
 Если цвет НЕ белый, сохраняет его в json.
 Если важность «обычная», НЕ сохраняет её в json.
 UIColor, enum, Date сохраняет в json НЕ в виде сложных объектов. То есть допустимы любые скалярные типы (Int, Double, …), строки, массивы и словари.*/


extension Note {
    
    private static var dateFmt: DateFormatter {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        return fmt
    }
    
    static func parse(json: [String : String]) -> Note? {
        // проверяю на обязательные параметры
        //UID, title, content у заметки всегда есть
        guard let uid = json["uid"],
            let title = json["title"],
            let content = json["content"]
            else {
            return nil
        }
        
        var importance = Importance.normal //в JSON не передаётся .normal, стало быть он идёт по умолчанию
        if let impString = json["importance"],
            let imp = Importance(rawValue: impString) {
            importance = imp
        }
        
        //парс цвета
        var color: UIColor = .white //в JSON не передаётся дефолтный цвет, стало быть он идёт по умолчанию
        
        if let colorString = json["color"],
            let col = UIColor(hex: colorString) {
            color = col
        }
        
        //парс destrDate
        var selfDestrDate: Date?
        
        if let dateStr = json["selfDestructionDate"],
            let date = dateFmt.date(from: dateStr) {
            selfDestrDate = date
        }
        
        let note = Note(uid: uid,
                        title: title,
                        content: content,
                        color: color,
                        importance: importance,
                        selfDestructionDate: selfDestrDate)
        
        return note
    }
    
    var json: [String: String] {
        var json: [String: String] = [:]
        
        json["uid"] = uid
        json["title"] = title
        json["content"] = content
        
        if color != .white {
            json["color"] = color.hexDescription()
        }
        
        if importance != .normal {
            json["importance"] = importance.rawValue
        }
        
        if let destrDate = selfDestructionDate {
            json["selfDestructionDate"] = Note.dateFmt.string(from: destrDate)
        }
        
        return json
    }
}
