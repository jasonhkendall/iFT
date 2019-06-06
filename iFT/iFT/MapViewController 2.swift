//
//  MapViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/24/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    // Update the map once the user has made their selection.
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        // Clear the map.
        mapView.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
            marker.snippet = selectedPlace?.formattedAddress
            marker.map = mapView
        }
        
        listLikelyPlaces()
    }
    
    
    // showMarker(position: CLLocationCoordinate2D)
    //
    //
    ////        let marker = GMSMarker()
    ////        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    ////        marker.title = "Sydney"
    ////        marker.snippet = "Australia"
    ////        marker.map = mapView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
        
        listLikelyPlaces()
    }
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
        })
    }
    
    // Prepare the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSelect" {
            if let nextViewController = segue.destination as? PlacesViewController {
                nextViewController.likelyPlaces = likelyPlaces
            }
        }
    }
}

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            // Handle unknown
            break
            
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}































































//class MapsViewController: UIViewController {
//
//
//
//
//   // @IBOutlet weak var mapView: UIView!
//    @IBOutlet fileprivate weak var mapView: GMSMapView!
//
//
//    // You don't need to modify the default init(nibName:bundle:) method.
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        func showMarker(position: CLLocationCoordinate2D){
//            let marker = GMSMarker()
//            marker.position = position
//            marker.title = "Palo Alto"
//            marker.snippet = "San Francisco"
////            marker.map = mapView
//        }
//
//        navigationItem.title = "User Location Preferences"
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//
//
//
//
//        // Creates a marker in the center of the map.
//
//       // showMarker(position: CLLocationCoordinate2D)
//
//
////        let marker = GMSMarker()
////        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
////        marker.title = "Sydney"
////        marker.snippet = "Australia"
////        marker.map = mapView
//
//
//
//
//        //mapView.delegate = self
//      //navigationItem.prompt = "Your prompt text here"
//
////        super.viewDidLoad()
////        let toolBar = UIToolbar()
////        var items = [UIBarButtonItem]()
////        items.append(UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil))
////        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getter: mapView)))
////        toolBar.setItems(items, animated: true)
////        toolBar.tintColor = .red
////        view.addSubview(toolBar)
////
////        toolBar.translatesAutoresizingMaskIntoConstraints = false
//    }
//}
//
//    extension MapsViewController: GMSMapViewDelegate{
//
//        // MapView delegate to store google maps enabled functions
//
//        // handles Info Window tap
//        func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//            print("didTapInfoWindowOf")
//        }
//
//        // handles Info Window long press
//        func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
//            print("didLongPressInfoWindowOf")
//        }
//
//        // set a custom Info Window
//        func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
//            view.backgroundColor = UIColor.white
//            view.layer.cornerRadius = 6
//
//            let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
//            lbl1.text = "Hi there!"
//            view.addSubview(lbl1)
//
//            let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
//            lbl2.text = "I am a custom info window."
//            lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
//            view.addSubview(lbl2)
//
//            return view
//        }}
//
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */


