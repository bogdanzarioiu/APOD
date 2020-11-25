//
//  NetworkManager.swift
//  APOD
//
//  Created by Bogdan on 10/16/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import Foundation
import UIKit


//protocol NetworkManagerDelegate {
//    func didFinishDownloadingDataFor(model: ImageOfTheDayModel)
//}


/* "https://api.nasa.gov/planetary/apod?api_key=AdmJQcQrQwQmDQcYzD4UBkgn076qS4GOASxpTxv4"
 */
class NetworkManager {
    let baseURL = "https://api.nasa.gov/planetary/apod?api_key=AdmJQcQrQwQmDQcYzD4UBkgn076qS4GOASxpTxv4"
    var model: ImageOfTheDayModel?
    //var delegate: NetworkManagerDelegate?
    
    func getData(completion: @escaping (ImageOfTheDayModel, String) -> ()) {
        let apodURL = URL(string: baseURL)
        guard let url = apodURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    
                  let decodedData = try? decoder.decode(ImageOfTheDayModel.self, from: data)
                    if let decodedData = decodedData {
                        self.model = ImageOfTheDayModel(explanation: decodedData.explanation, hdurl: decodedData.hdurl)
                        
                        completion(self.model!, self.model!.hdurl)
                        print("called")
                    }
                    
                    
                }
            }
            
        }.resume()
    }
    
    
    func getImageOfTheDay(completion: @escaping (ImageOfTheDayModel,UIImage) -> ()) {
        
        //get the image URL
        getData { (model, imageURL) in
            let imageURL = URL(string: imageURL)
            guard let safeImageURL = imageURL else { return }
            let task = URLSession.shared.dataTask(with: safeImageURL) { (data, response, error) in
                if error == nil && data != nil {
                    guard let data = data else { return }
                    print(data)
                    let imageOfTheDay = UIImage(data: data)
                    //let dataModel = model
                    //print(model.explanation)
                    completion(model,imageOfTheDay!)
                   
                    
                    
                }
            }
            task.resume()
        }
    }
}


