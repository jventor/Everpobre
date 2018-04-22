//
//  ModalNotebookChangeName.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit
import CoreData

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
    textField.placeholder = "Notebook name"
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
    
    
    navigationItem.title = "Create Notebook"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
  }
  
  
  @objc private func handleSave() {
    let context = Container.default.viewContext

    let notebook = Notebook(name: notebookNameTextField.text!, inContext: context)

    if context.hasChanges{
      do {
        try context.save()
        delegate?.didAddNotebook(notebook: notebook)
      } catch let saveErr {
        print("Failed to save notebook:", saveErr)
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
}
