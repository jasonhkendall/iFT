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


class MapsViewController: UINavigationController {
    
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar()
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getter: mapView))
        )
        toolBar.setItems(items, animated: true)
        toolBar.tintColor = .red
        view.addSubview(toolBar)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
