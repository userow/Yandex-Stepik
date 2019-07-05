//
//  NotesTests.swift
//  Yandex-Course-On-Stepik
//
//  Created by Paul Vasilenko on 6/30/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import XCTest
@testable import Notes

class NoteTests: XCTestCase {
    
    private let uid = "123"
    private let title = "title"
    private let content = "text"
    private let importance = Note.Importance.normal
    private var sut: Note!
    
    override func setUp() {
        super.setUp()
        sut = Note(title: title, content: content, importance: importance)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNote_isStruct() {
        guard let note = sut, let displayStyle = Mirror(reflecting: note).displayStyle else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(displayStyle, .struct)
    }
    
    func testNote_whenInitialized_isSetUid() {
        let note = Note(uid: uid, title: title, content: content, importance: importance)
        
        XCTAssertEqual(uid, note.uid)
    }
    
    func testNote_whenInitialized_isSetDefaultUid() {
        let note = Note(title: title, content: content, importance: importance)
        
        XCTAssertNotEqual(sut.uid, note.uid)
    }
    
    func testNote_whenInitialized_setTitle() {
        XCTAssertEqual(sut.title, title)
    }
    
    func testNote_whenInitialized_setContent() {
        XCTAssertEqual(sut.content, content)
    }
    
    func testNote_whenInitialized_setImportance() {
        XCTAssertEqual(sut.importance, importance)
    }
    
    
    func testNote_whenInitialized_defaultColor() {
        XCTAssertEqual(sut.color, .white)
    }
    
    func testNote_whenInitialized_customColor() {
        let color = UIColor.red
        let note = Note(title: title, content: content, color: color, importance: importance)
        
        XCTAssertEqual(note.color, color)
    }
    
    func testNote_whenInitialized_defaultDate() {
        XCTAssertNil(sut.selfDestructionDate)
    }
    
    func testNote_whenInitialized_customDate() {
        let date = Date()
        let note = Note(title: title, content: content, importance: importance, selfDestructionDate: date)
        
        XCTAssertEqual(date, note.selfDestructionDate)
    }
}

