//
//  ASAPODRequest.swift
//  AmazingSkies
//
//  Created by Oded Golden on 19/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ASAPODRequest
{
    let sampleUrl = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    
    // Container for core data work
    let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func fetchASAPODItem(date : String, hd : Bool, completion : @escaping (ASAPODItem) -> ()) -> ()
    {
        print("\nASAPOD Request Has been Fired.\n")
        let url = "\(constants.nasaAPODURL)?date=\(date)&api_key=\(constants.nasaAppToken)"

        Alamofire.request(url).responseJSON
            {
                [weak self]
                (response) in
                
                if let data = response.data
                {
                    let json = JSON(data: data)
                    let date = json["date"].stringValue
                    let explanation = json["explanation"].stringValue
                    let url = json["url"].stringValue
                    let hdurl = json["hdurl"].stringValue
                    let media_type = json["media_type"].stringValue
                    let service_version = json["service_version"].stringValue
                    let title = json["title"].stringValue
                    
                    self?.updateDatabase(date: date, explanation: explanation, hdurl: hdurl, media_type: media_type, service_version: service_version, title: title, url: url){(item) in
                        completion(item)
                    }
                }
        }
    }
    
    func updateDatabase(date: String, explanation: String, hdurl: String, media_type: String, service_version: String, title: String, url: String, completion : @escaping (ASAPODItem) -> ())
    {
        container?.performBackgroundTask{ (context) in
            let item = ASAPODItem.createASAPODItem(date: date, explanation: explanation, hdurl: hdurl, media_type: media_type, service_version: service_version, title: title, url: url, context: context)
            do {try context.save()}
            catch let error as NSError
            {
                print("Could not save. \(error), \(error.userInfo)")
            }
            completion(item)
        }
    }
}
