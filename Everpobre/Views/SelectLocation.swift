//
//  SelectLocation.swift
//  Everpobre
//
//  Created by Jaime Ventor on 22/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

protocol SelectionInMapViewControllerDelegate {
  func didSaveMapLocation(latitude: Double, longitude: Double)
}

class SelectionInMapViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
  
  let mapView : MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
  
  let textField : UITextField = {
    let text = UITextField()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
    return text
  }()
  
  let labelLocation : UITextField = {
    let label = UITextField()
    label.translatesAutoresizingMaskIntoConstraints  = false
    //label.backgroundColor = .red
    return label
  }()
  
  var delegate : SelectionInMapViewControllerDelegate?
  
  var noteLocation : CLLocation
  
  init(latitude: Double, longitude: Double) {
    let loc = CLLocation(latitude: latitude, longitude: longitude)
    self.noteLocation = loc
    self.textField.text = ""
    super.init(nibName: nil, bundle: nil)
  }
  
  init() {
    let loc = CLLocation(latitude: 30, longitude: 5)
    self.noteLocation = loc
    self.textField.text = ""
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func loadView() {
    
    let backView = UIView()
    
    backView.addSubview(mapView)
    mapView.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor).isActive = true
    mapView.leftAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.leftAnchor).isActive = true
    mapView.rightAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.rightAnchor).isActive = true
    mapView.bottomAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    backView.addSubview(textField)
    textField.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    textField.leftAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
    textField.rightAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    textField.heightAnchor.constraint(equalToConstant: 40)
    
    backView.addSubview(labelLocation)
    labelLocation.bottomAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    labelLocation.leftAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
    labelLocation.rightAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    labelLocation.heightAnchor.constraint(equalToConstant: 40)
    
    self.view = backView
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.delegate = self
    mapView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: noteLocation.coordinate.latitude, longitude: noteLocation.coordinate.longitude), span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    mapView.setRegion(region, animated: false)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Location", style: .plain, target: self, action: #selector(saveLocation))
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelLocation))
  }
  
  @objc func saveLocation(){
    //delegate?.didSaveMapLocation(location: noteLocation.la)
    delegate?.didSaveMapLocation(latitude: noteLocation.coordinate.latitude, longitude: noteLocation.coordinate.longitude)
    //delegate?.didSaveMapLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    dismiss(animated: true, completion: nil)
  }
  
  @objc func cancelLocation(){
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: MapView Delegates
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
    let centerCoord = mapView.centerCoordinate
    
    
    let location = CLLocation(latitude: centerCoord.latitude, longitude: centerCoord.longitude)
    labelLocation.text = "(\(location.coordinate.latitude), \(location.coordinate.longitude))"
    noteLocation = location

let geoCoder = CLGeocoder()
    
    geoCoder.reverseGeocodeLocation(location) { (placeMarkArray, error) in
      
      if let places = placeMarkArray {
        
        if let place = places.first {
          
          DispatchQueue.main.async
            {
              if let postalAdd = place.postalAddress
              {
                self.textField.text =  "\(postalAdd.street) ,  \(postalAdd.city)"
              }
          }
        }
      }
      
    }
 }
  
  // MARK: Text Field Delegate
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    mapView.isScrollEnabled = false
    
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    if textField.text != nil && !textField.text!.isEmpty
    {
      
      mapView.isScrollEnabled = false
      
      let geocoder = CLGeocoder()
      let postalAddress = CNMutablePostalAddress()
      
      postalAddress.street = textField.text!
      // postalAddress.subAdministrativeArea
      // postalAddress.subLocality
      postalAddress.isoCountryCode = "ES"
      
      geocoder.geocodePostalAddress(postalAddress) { (placeMarkArray, error) in
        
        if placeMarkArray != nil && placeMarkArray!.count > 0
        {
          let placemark = placeMarkArray?.first
          
          DispatchQueue.main.async
            {
              let region = MKCoordinateRegion(center:placemark!.location!.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.004, longitudeDelta: 0.004))
              self.mapView.setRegion(region, animated: true)
          }

        }
        
      }
    }
    
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
  }


}

