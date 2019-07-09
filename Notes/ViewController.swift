//
//  ViewController.swift
//  Notes
//
//  Created by Paul Vasilenko on 7/4/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
        tests()
    }
    
    func configure() {
        title = "Notes"
        
        guard let suffix = Config.suffix, let color = Config.barTintColor else {
            return
        }
        title?.append(suffix)
        navigationController?.navigationBar.barTintColor = color
    }
    
    func tests() {
        let sut = FileNotebook(filename: "test")
        
        let note = Note(title: "Title", content: "Text", importance: .normal)
        sut.add(note)
        
        let note2 = Note(title: "New Title", content: "My new text", color: .red, importance: .important, selfDestructionDate: Date())
        sut.add(note2)
        
        sut.saveToFile()
        
        sut.remove(with: note.uid)
        sut.remove(with: note2.uid)
        
        if sut.notes.isEmpty
        {
            print("OK!")
        } else {
            print("NOT OK!!!")
        }
        
        let note3 = Note(title: "New Title3", content: "My new text3", color: .green, importance: .unimportant, selfDestructionDate: Date())
        sut.add(note3)
        
        sut.loadFromFile()
        
        let notes = sut.notes
        testResult(notes.count == 2)
        
        if let _ = getNote(by: note.uid, from: notes) {
            testResult(true)
        } else {
            testResult(false)
        }
        if let _ = getNote(by: note2.uid, from: notes) {
            testResult(true)
        } else {
            testResult(false)
        }
    }

    private func getNote(by uid: String, from notes:Any) -> Note? {
        if let notes = notes as? [String: Note] {
            return notes[uid]
        }
        
        if let notes = notes as? [Note] {
            return notes.filter { $0.uid == uid }.first
        }
        
        return nil
    }

    private func testResult(_ result: Bool) {
        if result {
            print("OK!")
        } else {
            print("NOT OK!!!")
        }
    }
}

