//
//  Notes.swift
//  NotesApp
//
//  Created by Ионин Михаил Викторович on 01.10.2021.
//

import Foundation

class Notes {
    
    let defaults = UserDefaults.standard
    
    static let shared = Notes()
    
    struct Note: Codable {
        var noteTitle: String
        var noteBody: String
    }
    
    var notesArray: [Note] {
        
        get {
            if let data = defaults.value(forKey: "notesArray") as? Data {
                return try! PropertyListDecoder().decode([Note].self, from: data)
            } else {
                return [Note]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "notesArray")
            }
        }
    }
    
    func saveNote(title: String, body: String) {
        let note = Note(noteTitle: title, noteBody: body)
        notesArray.append(note)
    }
    
    func updateNote(title: String, body: String) {
        let note = Note(noteTitle: title, noteBody: body)
    }
}

struct KeyDefaults {
    static let title = "title"
    static let body = "body"
}


