//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Ионин Михаил Викторович on 01.10.2021.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var note: Notes.Note?
    
    var update = false
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if update == true {
            titleTextField.text = note?.noteTitle
            bodyTextField.text = note?.noteBody
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let title = titleTextField.text!
        let body = bodyTextField.text!
        
        if update == true {
            Notes.shared.updateNote(title: title, body: body)
        } else {
            Notes.shared.saveNote(title: title, body: body)
        }
        
        self.navigationController?.popViewController(animated: true)
            
    }
    
    
}
