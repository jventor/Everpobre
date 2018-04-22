//
//  ModalNotebookChangeName.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

protocol CreateNotebookControllerDelegate{
  func didAddNotebook(notebook: Notebook)
}

class CreateNotebookController: UIViewController {
  
  var delegate: CreateNotebookControllerDelegate?
  
  
  let notebookNameLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Notebook"
    return label
  }()
  
  let notebookNameTextField : UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = UIColor.lightGray
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    

    view.isOpaque = false
    
    view.addSubview(notebookNameLabel)
    notebookNameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    notebookNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    notebookNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    notebookNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    
    
    view.addSubview(notebookNameTextField)
    notebookNameTextField.topAnchor.constraint(equalTo: notebookNameLabel.bottomAnchor, constant: 10).isActive = true
    notebookNameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    notebookNameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    notebookNameTextField.heightAnchor.constraint(equalTo: notebookNameLabel.heightAnchor).isActive = true
    
    
    navigationItem.title = "Create Company"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
  }
  
  
  @objc private func handleSave() {
    print("Trying to save company...")
    let notebook = Notebook(name: notebookNameTextField.text ?? "", creationDate: Date(), notes: [])
    delegate?.didAddNotebook(notebook: notebook)
    dismiss(animated: true, completion: nil)
    
//    // initialization of our Core Data stack
//
//    let persistentContainer = NSPersistentContainer(name: "IntermediateTrainingModels")
//    persistentContainer.loadPersistentStores { (storeDescription, err) in
//      if let err = err {
//        fatalError("Loading of store failed: \(err)")
//      }
//    }
//
//    let context = persistentContainer.viewContext
//
//    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
//
//    company.setValue(nameTextField.text, forKey: "name")
//
//    // perform the save
//    do {
//      try context.save()
//    } catch let saveErr {
//      print("Failed to save company:", saveErr)
//    }
  }
  
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
}
