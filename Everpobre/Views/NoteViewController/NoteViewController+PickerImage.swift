//
//  NoteViewController+PickerImage.swift
//  Everpobre
//
//  Created by Jaime Ventor on 20/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

extension NoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
 // MARK: Image Picker Delegate
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    // Recogela imagen proveniente del Picker
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    // Creo una imageview para meter la imagen recogida
    let newImageView = UIImageView()
    newImageView.image = image
    
    // Se añade la nueva imageview a la vista de la nota
    // En mitad de la la vista de nota y con un tamaño inicial de 100x100
    view.addSubview(newImageView)
    let x = noteTextView.frame.width / 2
    let y = noteTextView.frame.height / 2
    newImageView.frame = CGRect(x: x, y: y, width: 100, height: 100)

    // Se activa la interaccion del usuario en la imageview nueva
    newImageView.isUserInteractionEnabled = true
    
    // Se le añade el gesto de longpress para poder moverla
    let moveViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(userMoveImage))
    newImageView.addGestureRecognizer(moveViewGesture)
    
    // Le añado al tag la posición que va a tener en el array de imageView de la nota
    // para poder tener el indice cuando quiera cambiar la posición, etc
    newImageView.tag = imageViewArray.count
    
    // Añado la imagen al array de imageviews
    imageViewArray.append(newImageView)
    
    // Añado la imagen a la nota
    let newImage = Image(image: image, x: x, y: y, width: 100, height: 100)
    note.images.append(newImage)

    picker.dismiss(animated: true, completion: nil)
    
  }
}


