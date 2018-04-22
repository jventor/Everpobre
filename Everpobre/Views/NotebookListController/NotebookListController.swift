//
//  ViewController.swift
//  Everpobre
//
//  Created by Jaime Ventor on 2/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit



class NotebookListController: UITableViewController{

  var notebooks = [Notebook]()
  var defaultNotebook : Notebook?
 // var selectedSection = 0
//
//  init(model : [Notebook]){
//    if model.count > 0 {
//     self.notebooks = model
//    }
//    else {
//      let defaultNotebook = Notebook(name: "My notebook", creationDate: Date(), notes: [Note()])
//      self.notebooks.append(defaultNotebook)
//    }
//
//    super.init(style: .plain)
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if notebooks.count == 0 {
      let newNotebook = Notebook(name: "My notebook", creationDate: Date(), notes: [])
      self.notebooks.append(newNotebook)
      self.defaultNotebook = newNotebook
    }
    else {
      defaultNotebook = notebooks[0]
    }
    
    view.backgroundColor = .lightGray
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Notebook", style: .plain, target: self, action: #selector(handleNewNotebook))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New note", style: .plain, target: self, action: #selector(handleNewNote))
  }

  @objc func handleNewNote(){
    print("Adding notes...")
    defaultNotebook?.notes.append(Note(notebook: defaultNotebook!))
    tableView.reloadData()
  }
  

  @objc func handleNewNotebook(){
    print("Adding notebooks...")

    let createNotebookController = CreateNotebookController()
        createNotebookController .delegate = self
    //modalViewController.modalPresentationStyle = UIModalPresentationStyle.blurOverFullScreen
    present(createNotebookController .wrappedInNavigation(), animated: true, completion: nil)
    
  }
  
  // MARK: UITableViewController Delegate
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return notebooks.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return notebooks[section].name
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notebooks[section].notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    
    cell.backgroundColor = .white
    
    let notebook = notebooks[indexPath.section].notes[indexPath.row]
    
    cell.textLabel?.text = "\(notebook.title) \(notebook.creationDate.description)"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    
    view.backgroundColor = UIColor.lightGray
    
    return view
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //selectedSection = indexPath.section
    let noteViewController = NoteViewController(model: notebooks[indexPath.section].notes[indexPath.row])
    noteViewController.delegate = self
    splitViewController?.showDetailViewController(noteViewController.wrappedInNavigation(), sender: nil)
  }
  
//  func firstNote() -> Note {
//    let note = notebooks.first?.notes.first ?? Note(title: "Default note", creationDate: Date(), expirationDate: Date(), text: "Nota por defecto", images: [])
//    notebooks.first?.notes.append(note)
//    return note
//  }
}

extension NotebookListController : CreateNotebookControllerDelegate {
  func didAddNotebook(notebook: Notebook) {
    print("Change notebook details...")
    notebooks.append(notebook)
    tableView.reloadData()
  }

}

extension NotebookListController : NoteViewControllerDelegate {
  func didChangeNote() {
    tableView.reloadData()
  }
  
  
}
