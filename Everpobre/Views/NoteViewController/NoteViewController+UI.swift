//
//  NoteViewController+UI.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

extension NoteViewController {

  
  func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(titleLabel)
    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10 ).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: 25)
    
    view.addSubview(titleTextField)
    titleTextField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    titleTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    titleTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
    
    view.addSubview(createDateLabel)
    createDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    createDateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
    createDateLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    createDateLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    
    view.addSubview(createDateTextField)
    createDateTextField.leftAnchor.constraint(equalTo: createDateLabel.rightAnchor).isActive = true
    createDateTextField.topAnchor.constraint(equalTo: createDateLabel.topAnchor).isActive = true
    createDateTextField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor).isActive = true
    createDateTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    
    view.addSubview(expirationDateLabel)
    expirationDateLabel.topAnchor.constraint(equalTo: createDateLabel.bottomAnchor, constant: 10).isActive = true
    expirationDateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
    expirationDateLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    expirationDateLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    
    view.addSubview(expirationDateTextField)
    expirationDateTextField.leftAnchor.constraint(equalTo: expirationDateLabel.rightAnchor).isActive = true
    expirationDateTextField.topAnchor.constraint(equalTo: expirationDateLabel.topAnchor).isActive = true
    expirationDateTextField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor).isActive = true
    expirationDateTextField.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    
    view.addSubview(notebookLabel)
    notebookLabel.topAnchor.constraint(equalTo: expirationDateLabel.bottomAnchor, constant: 10).isActive = true
    notebookLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
    notebookLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    notebookLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    
    view.addSubview(notebookTextField)
    notebookTextField.leftAnchor.constraint(equalTo: notebookLabel.rightAnchor).isActive = true
    notebookTextField.topAnchor.constraint(equalTo: notebookLabel.topAnchor).isActive = true
    notebookTextField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor).isActive = true
    notebookTextField.heightAnchor.constraint(equalTo: notebookLabel.heightAnchor).isActive = true
    
    view.addSubview(noteTextView)
    noteTextView.topAnchor.constraint(equalTo: notebookLabel.bottomAnchor, constant: 30).isActive = true
    noteTextView.leftAnchor.constraint(equalTo: notebookLabel.leftAnchor).isActive = true
    noteTextView.rightAnchor.constraint(equalTo: titleTextField.rightAnchor).isActive = true
    noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    
 // MARK: Navigation Controller
    navigationController?.isToolbarHidden = false
    
    let photoBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(catchPhoto))
    let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let mapBarButton = UIBarButtonItem(title: "Map", style: .done, target: self, action: #selector(addLocation))
    self.setToolbarItems([photoBarButton,flexible,mapBarButton], animated: false)
  }
  
  // MARK: Navigation options
  @objc func catchPhoto() {
    let actionSheetAlert = UIAlertController(title: NSLocalizedString("Add photo", comment: "Add photo"), message: nil, preferredStyle: .actionSheet)
    
    let imagePicker = UIImagePickerController()
    
    imagePicker.delegate = self
    
    let useCamera = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
      imagePicker.sourceType = .camera
      self.present(imagePicker, animated: true, completion: nil)
    }
    
    let usePhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
      imagePicker.sourceType = .photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    }
    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .destructive, handler: nil)
    
    actionSheetAlert.addAction(useCamera)
    actionSheetAlert.addAction(usePhotoLibrary)
    actionSheetAlert.addAction(cancel)
    
    present(actionSheetAlert, animated: true, completion: nil)
  }
  
  @objc func addLocation(){
    
  }
}
