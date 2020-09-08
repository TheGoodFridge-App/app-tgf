//
//  SettingsManager.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 9/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import Alamofire
import Foundation

struct SettingsManager {
    let urlString = "\(K.serverURL)/api/image"
    func uploadProfileImage(imageData: Data) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file.png", mimeType: "image")
        }, to: urlString)
            .responseJSON { response in
                debugPrint(response)
        }
    }
}
