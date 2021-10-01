//
//  AllNotesViewController.swift
//  NotesApp
//
//  Created by Ионин Михаил Викторович on 01.10.2021.
//

import UIKit

class AllNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "editNote" {
            vc.note = Notes.shared.notesArray[table.indexPathForSelectedRow!.row] 
            vc.update = true
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
}

