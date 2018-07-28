//
//  MapViewController.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 28.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CarProcessable {

    //MARK: - CarProcessable
    let downloadService = DownloadService()
    
    //MARK: - Private Properties
    private var carsArray: [Car] = [] {
        didSet {
            setupMapView()
        }
    }

    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        downloadCarList { [weak self] (cars) in
            self?.carsArray = cars
        }
    }
    
    //MARK: - Private Methods
    private func setupMapView() {
        let annotations = carsArray.compactMap { (car) -> MKPointAnnotation? in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: car.latitude,
                                                           longitude: car.longitude)
            annotation.title = "\(car.name) is here!"
            return annotation
        }
   
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
}
