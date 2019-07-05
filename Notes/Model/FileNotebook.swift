//
//  FileNotebook.swift
//  Yandex-Course-On-Stepik
//
//  Created by Paul Vasilenko on 7/1/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit

class FileNotebook {
    private var filename: String = "Notes.dat"
    public private(set) var notes: NSMutableDictionary = NSMutableDictionary()
    
    init (filename: String) {
        self.filename = filename
    }
    
    public func add(_ note: Note) {
        notes[note.uid] = note
    }
    
    public func remove(with uid: String) {
        notes[uid] = nil
    }
    
    public func saveToFile() {
        guard let url = fileUrl() else {
            return
        }
        
        let success = notes.write(to: url, atomically: true)
        print("write: ", success);
    }
    
    public func loadFromFile() {
        guard let url = fileUrl() else {
            return
        }
        
        if let dictionary = NSMutableDictionary(contentsOf: url) {
            print(dictionary)
            
            notes = dictionary
        }
    }
    
    private func fileUrl()-> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if let documentPath = paths.first {
            let filePath = NSMutableString(string: documentPath).appendingPathComponent(filename);
            
            let URL = NSURL.fileURL(withPath: filePath)
            
            return URL
        }
        
        return nil
    }
}


extension NSMutableDictionary {
    var isEmpty: Bool {
        let empty = self.allKeys.isEmpty
        
        return empty
    }
}
