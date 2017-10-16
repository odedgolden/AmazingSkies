//
//  ASApodDA.swift
//  AmazingSkies
//
//  Created by Oded Golden on 21/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation
import CoreData

class ASApodDA
{
    private let numberOfImagesToFetch = 8
    let calendar = NSCalendar.current
    let managedContext = AppDelegate.persistentContainer.viewContext
    
    func fetchNewImages(completion : @escaping ([ASAPODItem]) -> ()) -> ()
    {
        // Check when was the last update
        var items = [ASAPODItem]()

        let numberOfImagesMissing = calculateNumberOfDaysSinceLastUpdate()
        fetchNextImagesBlock(size: numberOfImagesMissing, offset: 0, completion: completion)
    }
    
    private func fetchNextImagesBlock(size : Int, offset : Int, completion : @escaping ([ASAPODItem]) -> ()) -> ()
    {
        var items = [ASAPODItem]()
        
        for i in offset...(offset+size)
        {
            let request = ASAPODRequest()
            let date = Date().addingTimeInterval(TimeInterval(-i*24*60*60))

            request.fetchImage(date: date, hd: false, completion: {
                (item) in
                items.append(item)
                if items.count == size
                {
                    completion(items)
                }
            })
        }
    }
    
    private func calculateNumberOfDaysSinceLastUpdate() -> (Int)
    {
        // Fetch last update from Core Data
        // TODO fetch request
        var lastUpdateDate = Date()
//        let fetchRequest = NSFetchRequest
        
        do
        {
            lastUpdateDate = try managedContext.fetch(ASAPODItem.fetchRequest() as! NSFetchRequest<NSFetchRequestResult>)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let today = Date()
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: lastUpdateDate)
        let date2 = calendar.startOfDay(for: today)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day!
    }
}
