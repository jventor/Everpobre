//
//  ViewController.swift
//  Everpobre
//
//  Created by Jaime Ventor on 2/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

struct Noteblock {
  var name : String
  var creationDate : Date
}

class NotebookListController: UITableViewController{

  var noteblocks = [Noteblock]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    
    noteblocks.append(Noteblock(name: "Block de notas 1", creationDate: Date()))
    noteblocks.append(Noteblock(name: "Block de notas 2", creationDate: Date()))
    
    //noteblocks.append(Noteblock(name: <#T##String#>, creationDate: Date()))
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
  }

  @objc func handleAdd(){
    print("Adding notebooks...")
  }
  
  // MARK: UITableViewController Delegate
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Notebooks"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return noteblocks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    
    cell.backgroundColor = .white
    
    let noteblock = noteblocks[indexPath.row]
    
    cell.textLabel?.text = "\(noteblock.name) \(noteblock.creationDate)"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    
    view.backgroundColor = UIColor.lightGray
    
    return view
  }
}

