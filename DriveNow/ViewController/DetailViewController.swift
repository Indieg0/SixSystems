//
//  DetailViewController.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
//Used only to make image caching easier :)

class DetailViewController: UIViewController {

    //MARK: - Public Properties
    var carModel: Car!
    
    //MARK: - IBOutlets
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var fuelTypeImageView: UIImageView!
    @IBOutlet weak var fuelLevelProgressView: UIProgressView!
    @IBOutlet weak var seriesLabel: UILabel!
    
    @IBOutlet weak var carPhotoImageView: UIImageView!
    @IBOutlet weak var licenseNumLabel: UILabel!
    
    @IBOutlet weak var carLocationMapView: MKMapView!
    
    //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        title = carModel.name
        modelLabel.text = carModel.modelName
        nameLabel.text = carModel.name
        transmissionLabel.text = carModel.transmission?.description
        fuelTypeImageView.image = carModel.fuelType?.image
        seriesLabel.text = carModel.series
        licenseNumLabel.text = carModel.licensePlate
        carPhotoImageView.kf.setImage(with: carModel.carImageUrl)
        setupProgressView(value: carModel.fuelLevel)
        setupMapView(latitude: carModel.latitude,
                     longitude: carModel.longitude,
                     carName: carModel.name)
    }
    
    private func setupProgressView(value: Double) {
        fuelLevelProgressView.progress = Float(value)
        switch value {
        case 0..<1/3:
            fuelLevelProgressView.progressTintColor = .red
        case 1/3..<2/3:
            fuelLevelProgressView.progressTintColor = .orange
        case 2/3..<1:
            fuelLevelProgressView.progressTintColor = .green
        default: break
        }
    }
    
    private func setupMapView(latitude: Double, longitude: Double, carName: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(carName) is here!"
        carLocationMapView.addAnnotation(annotation)
        
        let zoomDelta = 0.01
        let span = MKCoordinateSpanMake(zoomDelta, zoomDelta)
        let region = MKCoordinateRegionMake(annotation.coordinate, span)
        carLocationMapView.setRegion(region, animated: false)
    }
}
