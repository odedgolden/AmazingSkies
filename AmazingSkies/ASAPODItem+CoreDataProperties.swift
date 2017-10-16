//
//  ASAPODItem+CoreDataProperties.swift
//  AmazingSkies
//
//  Created by Oded Golden on 26/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation
import CoreData


extension ASAPODItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ASAPODItem> {
        return NSFetchRequest<ASAPODItem>(entityName: "ASAPODItem")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var url: String?
    @NSManaged public var media_type: String?
    @NSManaged public var service_version: String?
    @NSManaged public var title: String?
    @NSManaged public var thumbnail_image_data: NSData?

}
