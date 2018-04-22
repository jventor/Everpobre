//
//  ViewController.swift
//  Everpobre
//
//  Created by Jaime Ventor on 2/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit
import CoreData

class NotebookListController: UITableViewController, NSFetchedResultsControllerDelegate{

  var notebooks = [Notebook]()
  
  var fetchedResultController : NSFetchedResultsController<Notebook>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let context = Container.default.viewContext
    
    if let defaultNotebook = defaultNotebook(){
      
    }else{
      let notebook = Notebook(name: "My Notes", inContext: context)
      notebook.isDefault = 1
      do {
          try context.save()
      } catch let saveErr {
          print("Failed to save notebook:", saveErr)
      }
    }
    
    let fetchRequest = NSFetchRequest<Notebook>(entityName: "Notebook")
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(key: NotebookAttributes.isDefault.rawValue, ascending: false),
      NSSortDescriptor(key: NotebookAttributes.name.rawValue, ascending: true)
    ]
    
    fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

    try! fetchedResultController.performFetch()
    
    fetchedResultController.delegate = self
    
    view.backgroundColor = .lightGray
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleNewOptions))
  }

  @objc func handleNewOptions() {
    let actionSheetAlert = UIAlertController(title: NSLocalizedString("Add new", comment: "Add new"), message: nil, preferredStyle: .actionSheet)
    
    let newNotebook = UIAlertAction(title: NSLocalizedString("Notebook", comment: "Notebook"), style: .default) { (alertAction) in
        self.handleNewNotebook()
    }
    
    let newNote = UIAlertAction(title: NSLocalizedString("Note", comment: "Note"), style: .default) { (alertAction) in
      self.handleNewNote()
    }
    
    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .destructive, handler: nil)
    
    actionSheetAlert.addAction(newNotebook)
    actionSheetAlert.addAction(newNote)
    actionSheetAlert.addAction(cancel)
    
    present(actionSheetAlert, animated: true, completion: nil)
  }
  
 
  func handleNewNote(){
    let context = Container.default.viewContext
    let _ = Note(title: "Note title", text: "", notebook: defaultNotebook()!, inContext: context)
    if context.hasChanges{
      do {
        try context.save()
      } catch let saveErr {
        print("Failed to save notebook:", saveErr)
      }
    }
  }

  func handleNewNotebook(){
    let createNotebookController = CreateNotebookController()
    present(createNotebookController .wrappedInNavigation(), animated: true, completion: nil)
  }
  
  
  // MARK: UITableViewController Delegate
  
  override func numberOfSections(in tableView: UITableView) -> Int {
     return (fetchedResultController.fetchedObjects?.count)!
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return fetchedResultController.object(at: IndexPath(row: section, section: 0)).name
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let notesSortDescriptor = NSSortDescriptor(key: NoteAttributes.creationDate.rawValue, ascending: false)
    let notebook = fetchedResultController.object(at: IndexPath(row: section, section: 0))
    let notes = notebook.notes.sortedArray(using: [notesSortDescriptor]) as! [Note]
    return notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .white
    
    let notesSortDescriptor = NSSortDescriptor(key: NoteAttributes.creationDate.rawValue, ascending: false)
    let notebook = fetchedResultController.object(at: IndexPath(row: indexPath.section, section: 0))
    let notes = notebook.notes.sortedArray(using: [notesSortDescriptor]) as! [Note]
    let note = notes[indexPath.row]
    
    cell.textLabel?.text = note.title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let notesSortDescriptor = NSSortDescriptor(key: NoteAttributes.creationDate.rawValue, ascending: false)
    let notebook = fetchedResultController.object(at: IndexPath(row: indexPath.section, section: 0))
    let notes = notebook.notes.sortedArray(using: [notesSortDescriptor]) as! [Note]
    let note = notes[indexPath.row]
    
    let noteViewController = NoteViewController(model: note)
    noteViewController.delegate = self
    splitViewController?.showDetailViewController(noteViewController.wrappedInNavigation(), sender: nil)
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.reloadData()
  }
}

extension NotebookListController : NoteViewControllerDelegate {
  func didChangeNote() {
    let context = Container.default.viewContext
    if context.hasChanges{
      do {
        try context.save()
      } catch let saveErr {
        print("Failed to save image:", saveErr)
      }
    }
  }
}

extension NotebookListController {
  
  func defaultNotebook() -> Notebook? {
    var notebooks = [Notebook]()
    
    let context = Container.default.viewContext
    
    let req = Notebook.fetchRequest()
    req.predicate = NSPredicate(format: "isDefault == 1")
    
    do {
      notebooks = try context.fetch(req) as! [Notebook]
      
      dump(notebooks.count)
      dump(notebooks)
      return notebooks.first
      
    } catch let fetchErr {
      print("Failed to fetch default notebook:", fetchErr)
      let notebook = Notebook(name: "default", inContext: context)
      notebook.isDefault = 1
      return notebook
    }
  }
}
