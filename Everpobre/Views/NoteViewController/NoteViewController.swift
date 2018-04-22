//
//  NoteViewController.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

protocol NoteViewControllerDelegate {
  func didChangeNote()
}

final class NoteViewController : UIViewController {
  
  var note : Note
  var delegate : NoteViewControllerDelegate?
  
  let titleLabel : UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  let titleTextField : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.lightGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  let createDateLabel : UILabel = {
    let label = UILabel()
    label.text = "Created at"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  let createDateTextField : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.lightGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.text = "01/01/2018"
    return textField
  }()
  
  let expirationDateLabel : UILabel = {
    let label = UILabel()
    label.text = "Expire at"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  let expirationDateTextField : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.lightGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.text = "01/01/2018"
    return textField
  }()
  
  let datePicker = UIDatePicker()
  
  let notebookLabel : UILabel = {
    let label = UILabel()
    label.text = "Notebook"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let notebookTextField : UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.lightGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  let notebookPickerView = UIPickerView()
  
  let noteTextView : UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = UIColor.lightGray
    textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    return textView
  }()
  
 // var moveViewGesture : UILongPressGestureRecognizer?

  
  var relativePoint: CGPoint!
  
  var imageViewArray = [UIImageView]()
  

  init(model: Note) {
//    if let model = model {
//         self.note = model
//    }
//    else{
//      self.note = Note()
//    }
    self.note = model
    super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
override func viewDidLoad() {
    super.viewDidLoad()
  
  
    setupUI()
  
    titleTextField.delegate = self
    titleTextField.text = note.title
  
    noteTextView.delegate = self
    noteTextView.text = note.text
  
    createDateTextField.text = note.creationDate.description
    createDateTextField.isEnabled = false
  
    datePicker.datePickerMode = .date
    datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
    datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    datePicker.minimumDate = Date()
  
    expirationDateTextField.text = note.expirationDate.description
    expirationDateTextField.inputView = datePicker
  
    notebookPickerView.delegate = self
    notebookPickerView.dataSource = self
  
    notebookTextField.inputView = notebookPickerView
    notebookTextField.text = note.notebook?.name
    showImages()
  
    // MARK: Gestures

  
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeKeyboard))
    swipeGesture.direction = .down
  
    view.addGestureRecognizer(swipeGesture)

  //imageView.addGestureRecognizer(moveViewGesture)

  }
  
  @objc func closeKeyboard(){
    
    
    if noteTextView.isFirstResponder
    {
      noteTextView.resignFirstResponder()
    }
    else if titleTextField.isFirstResponder
    {
      titleTextField.resignFirstResponder()
    }
  }
  
  @objc func userMoveImage(longPressGesture:UILongPressGestureRecognizer)
  {
    let imageView = longPressGesture.view as! UIImageView
    print("entro...")
    switch longPressGesture.state {
    case .began:
      closeKeyboard()
      relativePoint = longPressGesture.location(in: longPressGesture.view)
      UIView.animate(withDuration: 0.1, animations: {
        imageView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
      })
      
    case .changed:
      let location = longPressGesture.location(in: view)

      imageView.frame = CGRect(x: location.x - relativePoint.x, y: location.y - relativePoint.y, width:
      imageView.frame.size.width, height: imageView.frame.size.height)
      note.images[imageView.tag].x = location.x - relativePoint.x
      note.images[imageView.tag].y = location.y - relativePoint.y
      
    case .ended, .cancelled:
      
      UIView.animate(withDuration: 0.1, animations: {
        imageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
      })
      
    default:
      break
    }
    
  
  }
  
  @objc func datePickerValueChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Const.DateFormat
    //
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = Const.DateFormat

    expirationDateTextField.text = dateFormatter.string(from: datePicker.date)
    note.expirationDate = (expirationDateTextField.text?.toDate(format: Const.DateFormat))!
  }
  
  func showImages(){

    for index in 0..<note.images.count{
      let image = note.images[index]
      let newImageView = UIImageView()
      newImageView.image = image.image
      view.addSubview(newImageView)
      newImageView.frame = CGRect(x: Double(image.x), y: Double(image.y), width: image.width, height: image.height)
      newImageView.isUserInteractionEnabled = true
      let moveViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(userMoveImage))
      newImageView.addGestureRecognizer(moveViewGesture)
      newImageView.tag = index
      imageViewArray.append(newImageView)
   }

  }
  
  
//  override func viewDidLayoutSubviews() {
//    var rect = view.convert(imageView.frame, to: noteTextView)
//    rect = rect.insetBy(dx: -15, dy: -15)
//
//    let paths = UIBezierPath(rect: rect)
//    noteTextView.textContainer.exclusionPaths = [paths]
//  }
}

extension NoteViewController : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    note.title = titleTextField.text!
    delegate?.didChangeNote()

    
    //try! note?.managedObjectContext?.save()
  }
}

extension NoteViewController : UITextViewDelegate{
  func textViewDidEndEditing(_ textView: UITextView) {
    note.text = noteTextView.text!
  }
}

extension NoteViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
   return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var theViewController : NotebookListController
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    theViewController = appDelegate.notebookListVC!
    
    return theViewController.notebooks.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    var theViewController : NotebookListController
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    theViewController = appDelegate.notebookListVC!
    
    return theViewController.notebooks[row].name
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    var theViewController : NotebookListController
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    theViewController = appDelegate.notebookListVC!

    note.notebook = theViewController.notebooks[row]
    notebookTextField.text = note.notebook?.name

    self.delegate?.didChangeNote()
  }
}

