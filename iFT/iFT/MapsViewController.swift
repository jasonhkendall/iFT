//
//  MapsViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/24/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleMaps
import GooglePlaces


class MapsViewController: UIViewController {
    
    
    
    
   // @IBOutlet weak var mapView: UIView!
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "User Location Preferences"
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 6.0)
        mapView.camera = camera
        
        
        
        
        // Creates a marker in the center of the map.
        func showMarker(position: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = position
            marker.title = "Palo Alto"
            marker.snippet = "San Francisco"
            marker.map = mapView
        }
       // showMarker(position: CLLocationCoordinate2D)
            
            
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    
    
   
    
        //mapView.delegate = self
      //navigationItem.prompt = "Your prompt text here"
        
//        super.viewDidLoad()
//        let toolBar = UIToolbar()
//        var items = [UIBarButtonItem]()
//        items.append(UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil))
//        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getter: mapView)))
//        toolBar.setItems(items, animated: true)
//        toolBar.tintColor = .red
//        view.addSubview(toolBar)
//
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
    }
}
    
    extension MapsViewController: GMSMapViewDelegate{
        
        // MapView delegate to store google maps enabled functions
       
        // handles Info Window tap
        func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
            print("didTapInfoWindowOf")
        }
        
        // handles Info Window long press
        func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
            print("didLongPressInfoWindowOf")
        }
        
        // set a custom Info Window
        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 6
            
            let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
            lbl1.text = "Hi there!"
            view.addSubview(lbl1)
            
            let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
            lbl2.text = "I am a custom info window."
            lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
            view.addSubview(lbl2)
            
            return view
        }}
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

