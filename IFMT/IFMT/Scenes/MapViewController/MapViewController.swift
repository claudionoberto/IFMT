//
//  MapViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setMapContraints()
        addpin()
    }
    
    func setMapContraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func addpin() {
        let pin = MKPointAnnotation()
        pin.title = "IFMT"
        pin.coordinate = CLLocationCoordinate2D(latitude: -15.592394821826842, longitude: -56.098377145229215)
        mapView.addAnnotation(pin)
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -15.592394821826842, longitude: -56.098377145229215), latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
    }

}
