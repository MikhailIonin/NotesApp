//
//  AllNotesViewController.swift
//  NotesApp
//
//  Created by Ионин Михаил Викторович on 01.10.2021.
//

import UIKit

class AllNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    //var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.table.reloadData()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let addNoteVC = segue.destination as? AddNoteViewController else { return }
//
//        if segue.identifier == "editNote" {
//            addNoteVC.note = Notes.shared.notesArray[table.indexPathForSelectedRow!.row]
//            addNoteVC.update = true
//            addNoteVC.selectedRow = selectedRow
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        
        if let addNoteVC = storyboard?.instantiateViewController(identifier: "addNote") as? AddNoteViewController {
            addNoteVC.note = Notes.shared.notesArray[selectedRow]
            addNoteVC.selectedRow = selectedRow
            addNoteVC.update = true
            navigationController?.pushViewController(addNoteVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.shared.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Notes.shared.notesArray[indexPath.row].noteTitle
        cell.detailTextLabel?.text = Notes.shared.notesArray[indexPath.row].noteBody
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedRow = indexPath.row
//        print(selectedRow ?? "error in allVC")
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            table.beginUpdates()
            Notes.shared.notesArray.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
            table.endUpdates()
        }
    }
    
}

