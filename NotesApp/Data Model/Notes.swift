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
    
    //Get from / set data in UserDefaults
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
    
    //Save new note
    func saveNote(title: String, body: String) {
        let note = Note(noteTitle: title, noteBody: body)
        notesArray.append(note)
    }
    
    //Update existing note
    func updateNote(title: String, body: String, index: Int) {
        notesArray[index].noteTitle = title
        notesArray[index].noteBody = body
    }
}

//Keys for UserDefaults
struct KeyDefaults {
    static let title = "title"
    static let body = "body"
}




