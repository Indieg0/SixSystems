//
//  CarProcessable.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 28.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import Foundation

protocol CarProcessable {
    var downloadService: DownloadService { get }
    func downloadCarList(completion: @escaping (([Car]) -> Void))
}

extension CarProcessable {
    func downloadCarList(completion: @escaping (([Car]) -> Void)) {
        downloadService.downloadCarList { (cars) in
            guard let cars = cars else {
                return //Handle error
            }
            completion(cars)
        }
    }
}
