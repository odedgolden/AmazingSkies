//
//  ASDate.swift
//  AmazingSkies
//
//  Created by Oded Golden on 06/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation

extension Date
{
    func parseDateForRequest() -> String
    {
        return "\(self.year)-\(self.month)-\(self.day)"
    }
    
    init(apod_date_format : String)
    {
        var stringComponents = apod_date_format.components(separatedBy: "-")
        if stringComponents.count == 3
        {
            var components = DateComponents()
            components.year = Int(stringComponents[0])
            components.month = Int(stringComponents[1])
            components.day = Int(stringComponents[2])
            self =  Calendar.current.date(from: components)!
        }
        else
        {
            self = Date()
        }
    }
    
    var day : String
    {
        let day = Calendar.current.component(.day, from: self)
        return String(format: "%02d", day)
    }
    
    var month : String
    {
        let month = Calendar.current.component(.month, from: self)
        return String(format: "%02d", month)

    }
    
    var year : String
    {
        return String(Calendar.current.component(.year, from: self))
    }
}
