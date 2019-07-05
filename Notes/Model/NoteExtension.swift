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

extension UIColor {
    
    //UIColor to HEX string
    public func hexDescription() -> String {
        guard self.cgColor.numberOfComponents == 4 else {
            return "#FFFFFF"
        }
        let a = self.cgColor.components!.map { Int($0 * CGFloat(255)) }
        let color = String.init(format: "#%02x%02x%02x", a[0], a[1], a[2])
        
        return color
    }
    
    
    convenience init(r: UInt8, g: UInt8, b: UInt8, alpha: CGFloat = 1.0) {
        let divider: CGFloat = 255.0
        self.init(red: CGFloat(r)/divider, green: CGFloat(g)/divider, blue: CGFloat(b)/divider, alpha: alpha)
    }
    
    private convenience init(rgbWithoutValidation value: Int32, alpha: CGFloat = 1.0) {
        self.init(
            r: UInt8((value & 0xFF0000) >> 16),
            g: UInt8((value & 0x00FF00) >> 8),
            b: UInt8(value & 0x0000FF),
            alpha: alpha
        )
    }
    
    convenience init?(rgb: Int32, alpha: CGFloat = 1.0) {
        if rgb > 0xFFFFFF || rgb < 0 { return nil }
        self.init(rgbWithoutValidation: rgb, alpha: alpha)
    }
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var charSet = CharacterSet.whitespacesAndNewlines
        charSet.insert("#")
        let _hex = hex.trimmingCharacters(in: charSet)
        guard _hex.range(of: "^[0-9A-Fa-f]{6}$", options: .regularExpression) != nil else { return nil }
        var rgb: UInt32 = 0
        Scanner(string: _hex).scanHexInt32(&rgb)
        self.init(rgbWithoutValidation: Int32(rgb), alpha: alpha)
    }
}

extension Note {
    static func parse(json: [String : Any]) -> Note? {
        // проверяю на обязательные параметры
        //UID, title, content у заметки всегда есть
        guard let uid = json["uid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String
            else {
            return nil
        }
        
        var importance = Importance.normal //в JSON не передаётся .normal, стало быть он идёт по умолчанию
        if let impString = json["importance"] as? String,
            let imp = Importance(rawValue: impString) {
            importance = imp
        }
        
        //парс цвета
        var color: UIColor = .white //в JSON не передаётся дефолтный цвет, стало быть он идёт по умолчанию
        
        if let colorString = json["color"] as? String,
            let col = UIColor(hex: colorString) {
            color = col
        }
        
        //парс destrDate
        var selfDestrDate: Date?
            
        if let date = json["selfDestructionDate"] as? TimeInterval {
            selfDestrDate = Date(timeIntervalSince1970: date)
        }
        
        let note = Note(uid: uid,
                        title: title,
                        content: content,
                        color: color,
                        importance: importance,
                        selfDestructionDate: selfDestrDate)
        
        return note
    }
    
    var json: [String: Any] {
        var json: [String: Any] = [:]
        
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
            json["selfDestructionDate"] = destrDate.timeIntervalSince1970
        }
        
        return json
    }
}
