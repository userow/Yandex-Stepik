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
    public private(set) var notes: [String : Note] = [:]
    
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
        
        var notesArr: [[String : String]] = []
        
        notes.forEach { (key, value) in
            notesArr.append(value.json)
        }
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(notesArr) {
            do {
               try jsonData.write(to: url, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func loadFromFile() {
        guard let url = fileUrl() else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url, options: [])
            
            let notesarray = try JSONDecoder().decode([[String : String]].self, from: data)
            
            var notesFromFile : [String : Note] = [:]
            
            notesarray.forEach { value in
                if let note = Note.parse(json: value) {
                    notesFromFile[note.uid] = note
                }
            }
            
            self.notes = notesFromFile
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fileUrl() -> URL? {
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
