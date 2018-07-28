//
//  DownloadManager.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import Foundation

final class DownloadManager: NSObject, URLSessionDownloadDelegate {
    
    //MARK: - Private Properties
    private let sessionIdentifier = "Download"
    
    fileprivate lazy var session: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: sessionIdentifier)
        config.urlCache = nil
        return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    fileprivate var completionHandler: ((Bool) -> Void)?
    
    //MARK: - Public Methods
    func downloadFileWith(_ url: URL, completion:@escaping (Bool) -> Void){
        self.completionHandler = completion
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }

    //MARK: - URLSessionDownloadDelegate
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let fileManager = FileManager.default
        guard let sourceURL = downloadTask.originalRequest?.url,
            let destinationURL = fileManager.localFilePath(for: sourceURL) else { return }
        
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            completionHandler?(true)
        } catch {
            print("Could not copy file to disk: \(error.localizedDescription)")
            completionHandler?(false)
        }
    }
    
}
