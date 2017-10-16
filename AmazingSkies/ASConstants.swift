//
//  ASEpicConstants.swift
//  AmazingSkies
//
//  Created by Oded Golden on 06/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation

// MARK: - Constants

struct constants
{
    static let nasaAppToken = "7OgT2GKKdC8O0uVl2R3ULEdI9pR82aENofGw4vqj"
    
    static let nasaEpicURL = "https://api.nasa.gov/EPIC/"
    static let nasaAPODURL = "https://api.nasa.gov/planetary/apod"
    static let limit = 50
    
    static let sampleURL = "https://api.nasa.gov/EPIC/archive/natural/2015/06/13/png/epic_1b_20150613110250_01.png?api_key=DEMO_KEY"
}

// MARK: - Enums

enum RequestType : String
{
    case api = "api"
    case archive = "archive"
}

enum CollectionType : String
{
    case natural = "natural"
    case enhanced = "enhanced"
}

enum ImageType : String
{
    case png = ".png"
    case jpg = ".jpg"
}
