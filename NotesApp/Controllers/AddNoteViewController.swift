//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Ионин Михаил Викторович on 01.10.2021.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate {
    
    var note: Notes.Note?
    var selectedRow: Int?
    var update = false
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTextView.delegate = self
        
        if update == true {
            titleTextField.text = note?.noteTitle
            bodyTextView.text = note?.noteBody
            
        } else {
            bodyTextView.text = "Enter note text here"
            bodyTextView.textColor = UIColor.lightGray
        }
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        titleTextField.inputAccessoryView = toolBar
        bodyTextView.inputAccessoryView = toolBar
    }
    
    @objc private func didTapDone() {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bodyTextView.textColor == UIColor.lightGray {
            bodyTextView.text = nil
            bodyTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bodyTextView.text.isEmpty {
            bodyTextView.text = "Enter note text here"
            bodyTextView.textColor = .lightGray
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let title = titleTextField.text!
        let body = bodyTextView.text!
        
        if title.isEmpty {
            showAlert(with: "The note has no title" , and: "Please, enter a title for the note")
        } else {
            if bodyTextView.textColor == UIColor.lightGray || body.isEmpty {
                showAlert(with: "The note has no text" , and: "Please, enter a text in the note")
            } else {
                writeToMemory(title: title, body: body, update: update)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func writeToMemory(title: String, body: String, update: Bool) {
        if update == true {
            Notes.shared.updateNote(title: title, body: body, index: selectedRow!)
        } else {
            Notes.shared.saveNote(title: title, body: body)
        }
    }
}

extension AddNoteViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
