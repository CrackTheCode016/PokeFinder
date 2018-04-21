//
//  ViewController.swift
//  PokeFinder
//
//  Created by Santiago on 10/19/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce: Bool = false
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    var pokeNumber: Int!
    
    @IBOutlet weak var reCenterMap: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geoFireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        showSightingsOnMap(location: loc)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Map", style: .done, target: nil, action: nil)
        
    }
    
    
    @IBAction func reCenterBtnPress(_ sender: Any) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: location)
                mapHasCenteredOnce = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoIdent = "Pokemon"
        var annotationView: MKAnnotationView?
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "ash")
        } else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdent) {
            annotationView = deqAnno
            annotationView?.annotation = annotation
        }
        
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdent)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            av.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView, let annotation = annotation as? PokeAnnotation {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "\(annotation.pokeNumber)")
            let rightButton = UIButton()
            let leftButton = UIButton()
            leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            leftButton.setImage(UIImage(named: "delete"), for: .normal)
            rightButton.setImage(UIImage(named: "map"), for: .normal)
            annotationView.leftCalloutAccessoryView = leftButton
            annotationView.rightCalloutAccessoryView = rightButton
            
        }
        return annotationView
        
    }
    
    func createSighting(forLocation location: CLLocation, WithPokemon pokeId: Int) {
        geoFire.setLocation(location, forKey: "\(pokeId)")
    }
    
    func removeSighting(WithPokemon pokeId: Int, annotation: MKAnnotation) {
        geoFire.removeKey("\(pokeId)")
        mapView.removeAnnotation(annotation)
        mapView.reloadInputViews()

    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        showSightingsOnMap(location: loc)
        print(pokeNumber)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let anno = view.annotation as? PokeAnnotation {
            if control == view.rightCalloutAccessoryView {
                let place = MKPlacemark(coordinate: anno.coordinate)
                let destination = MKMapItem(placemark: place)
                destination.name = "Pokemon Sighting"
                let regionDistance: CLLocationDistance = 1000
                
                let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
                
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
                
                MKMapItem.openMaps(with: [destination], launchOptions: options)
            }
            
            else if control == view.leftCalloutAccessoryView {
                removeSighting(WithPokemon: anno.pokeNumber, annotation: anno)
                view.reloadInputViews()
            }
        }
        
        
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        
    }
    
    func showSightingsOnMap(location: CLLocation) {
        let circleQuery = geoFire.query(at: location, withRadius: 3)
        
        _ = circleQuery?.observe(GFEventType.keyEntered, with: { (key, location) in
            if let key = key, let location = location {
                let anno = PokeAnnotation(coordinate: location.coordinate, pokeNumber: Int(key)!)
                self.mapView.addAnnotation(anno)
            }
        })
    }
    
    @IBAction func randomPokemonButtonPress(_ sender: Any) {
        
    }
}

