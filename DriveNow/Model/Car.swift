//
//  Car.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit

enum FuelType: String, Codable {
    case petrol = "P"
    case diesel = "D"
    case electric = "E"
    
    var image: UIImage {
        switch self {
        case .diesel:
            return #imageLiteral(resourceName: "diesel")
        case .electric:
            return #imageLiteral(resourceName: "charging")
        case .petrol:
            return #imageLiteral(resourceName: "petrol")
        }
    }
}


enum TransmissionClass: String, Codable {
    case automatic = "A"
    case manual = "M"
    
    var description: String {
        switch self {
        case .automatic:
            return "Automatic"
        case .manual:
            return "Manual"
        }
    }
}

struct Car: Codable {
    
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let series: String
    let fuelLevel: Double
    let licensePlate: String
    let latitude: Double
    let longitude: Double
    let carImageUrl: URL
    let fuelType: FuelType?
    let transmission: TransmissionClass?
    
    //MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case modelIdentifier
        case modelName
        case name
        case series
        case fuelType
        case transmission
        case fuelLevel
        case licensePlate
        case latitude
        case longitude
        case carImageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
        self.modelIdentifier = try container.decode(String.self, forKey: CodingKeys.modelIdentifier)
        self.modelName = try container.decode(String.self, forKey: CodingKeys.modelName)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.series = try container.decode(String.self, forKey: CodingKeys.series)
        let fuelType = try container.decode(String.self, forKey: CodingKeys.fuelType)
        self.fuelType = FuelType(rawValue: fuelType)
        let transmission = try container.decode(String.self, forKey: CodingKeys.transmission)
        self.transmission = TransmissionClass(rawValue: transmission)
        self.fuelLevel = try container.decode(Double.self, forKey: CodingKeys.fuelLevel)
        self.licensePlate = try container.decode(String.self, forKey: CodingKeys.licensePlate)
        self.latitude = try container.decode(Double.self, forKey: CodingKeys.latitude)
        self.longitude = try container.decode(Double.self, forKey: CodingKeys.longitude)
        self.carImageUrl = try container.decode(URL.self, forKey: CodingKeys.carImageUrl)
    }
}

