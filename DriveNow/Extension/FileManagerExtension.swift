//
//  FileManagerExtension.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import Foundation

extension FileManager {
    func localFilePath(for url: URL) -> URL? {
        let documentsPath = self.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsPath?.appendingPathComponent(url.lastPathComponent)
    }
}
