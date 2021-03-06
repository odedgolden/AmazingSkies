//
//  ASAPODItem+CoreDataClass.swift
//  AmazingSkies
//
//  Created by Oded Golden on 26/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation
import CoreData


public class ASAPODItem: NSManagedObject
{
    class func fetchItem(date : String, context : NSManagedObjectContext) throws -> ASAPODItem?
    {
        let request : NSFetchRequest<ASAPODItem> = ASAPODItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", date)
        
        do {
            let matchingASAPODItems = try context.fetch(request)
            if matchingASAPODItems.count > 0
            {
                assert(matchingASAPODItems.count == 1, "Things with ASAPODItem went bad on core data")
                return matchingASAPODItems[0]
            }
        }
        catch
        {
            throw error
        }
        return nil
    }
    
    class func createASAPODItem(date : String, explanation : String, hdurl : String, media_type : String, service_version : String, title : String, url : String, context: NSManagedObjectContext) -> ASAPODItem
    {
        do {
            if let item = try fetchItem(date: date, context: context)
            {
                return item
            }
        }
        catch {
            print(error)
        }
        
        let item = ASAPODItem(context : context)
        
        item.id = date
        item.date = Date(apod_date_format: date)
        item.explanation = explanation
        item.hdurl = hdurl
        item.media_type = media_type
        item.service_version = service_version
        item.title = title
        item.url = url
        
        return item
    }
    
    class func setThumbnailImageData(id: String, imageData: Data, context: NSManagedObjectContext)
    {
        let request : NSFetchRequest<ASAPODItem> = ASAPODItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)

        do {
            let matchingASAPODItems = try context.fetch(request)
            if matchingASAPODItems.count > 0
            {
                assert(matchingASAPODItems.count == 1, "Things with ASAPODItem went bad on core data")
                matchingASAPODItems[0].thumbnail_image_data = imageData
                try? context.save()
            }
        }
        catch
        {
            // Do nothing
        }
    }
}
