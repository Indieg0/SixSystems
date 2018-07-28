//
//  DownloadService.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import Foundation

final class DownloadService {
    
    //MARK: - FileEndpoint
    private enum FileEndpoint: String {
        case cars = "cars.json"
    }
    
    //MARK: - Public Constants
    private let downloadManager = DownloadManager()
    private let fileManager = FileManager.default
    
    //MARK: - Public Constants
    let globalUrlString = "http://www.codetalk.de/"
    
    //MARK: - Public Methods
    func downloadCarList(completion: @escaping ([Car]?) -> Void) {
        let urlString = globalUrlString + FileEndpoint.cars.rawValue
        
        guard let url = URL(string: urlString),
            let destinationURL = fileManager.localFilePath(for: url) else {
            return completion(nil)
        }
        
        do {
            let jsonData = try Data(contentsOf: destinationURL)
            let cars = try JSONDecoder().decode([Car].self, from: jsonData)
            completion(cars)
        } catch {
            downloadManager.downloadFileWith(url) { (completed) in
                guard completed else { return }
                DispatchQueue.main.async {
                    do {
                        let jsonData = try Data(contentsOf: destinationURL)
                        let cars = try JSONDecoder().decode([Car].self, from: jsonData)
                        completion(cars)
                    } catch {
                        completion(nil)
                    }
                }
            }
        }
        
        
    }
    
}
