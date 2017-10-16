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
    
    func fetchImage(date : Date, hd : Bool, completion : @escaping (ASAPODItem) -> ()) -> ()
    {
        print("\nASAPOD Request Has been Fired.\n")
        let dateString = date.parseDateForRequest(date: date)
        let url = "\(constants.nasaAPODURL)?date=\(dateString)&api_key=\(constants.nasaAppToken)"

        Alamofire.request(url).responseJSON
            {
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
                    
                    
                    let apodItem = ASAPODItem(entity: ASAPODItem.entity(), insertInto: AppDelegate.persistentContainer.viewContext)
                    apodItem.date = Date(apod_date_format: date)
                    apodItem.explanation = explanation
                    apodItem.url = url
                    apodItem.hdurl = hdurl
                    apodItem.media_type = media_type
                    apodItem.service_version = service_version
                    apodItem.title = title
                    
                    do
                    {
                        try AppDelegate.persistentContainer.viewContext.save()
                        completion(apodItem)
                    }
                    catch let error as NSError
                    {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
        }
    }
}
