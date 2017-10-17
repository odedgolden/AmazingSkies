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
    private let numberOfImagesToFetch = 100
    let calendar = NSCalendar.current
    let managedContext : NSManagedObjectContext!
    let apodRequest = ASAPODRequest()

    init(managedContext : NSManagedObjectContext)
    {
        self.managedContext = managedContext
    }
    
    func fetchASAPODItems(numberOfASAPODItemsToFetch : Int, completion : @escaping ([ASAPODItem]) -> ()) -> ()
    {
        var items = [ASAPODItem]()
        let today = Date()
        
        for i in 0...numberOfImagesToFetch
        {
            let currentDateString = today.addingTimeInterval(TimeInterval(-i*24*60*60)).parseDateForRequest()
            
            // First, check if the item is in core data
            if let apodItem = try? ASAPODItem.fetchItem(date: currentDateString, context: managedContext),
                apodItem != nil
            {
                items.append(apodItem!)
                if items.count == numberOfImagesToFetch
                {
                    completion(items)
                }
            }
            
            // If no saved item is to be found - fetch item from the API, and save it to core data
            DispatchQueue.global().async
                {
                    self.apodRequest.fetchASAPODItem(date: currentDateString, hd: false, completion: { (item) in
                        items.append(item)
                        
                        if items.count == numberOfASAPODItemsToFetch
                        {
                            completion(items)
                        }
                    })
            }
        }
    }


}
