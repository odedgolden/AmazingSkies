//
//  ASAPODImageRequest.swift
//  AmazingSkies
//
//  Created by Oded Golden on 23/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import Foundation
import UIKit

class ASAPODImageRequest :Operation
{
    var apodItem : ASAPODItem
    var successCompletionHandler : ((UIImage) -> ())?
    var image : UIImage?
    
    init(item: ASAPODItem, completion : ((UIImage) -> ())?)
    {
        apodItem = item
        successCompletionHandler = completion
    }
    
    override func main()
    {
        print("\nASAPOD Image Request Has been Fired.\n")

        DispatchQueue.global().async
            {
                [weak self]  in
                
                if let urlString = self?.apodItem.url,
                    let url = URL(string:urlString)
                {
                    let urlContents = try? Data(contentsOf: url)
                    if let imageData = urlContents
                    {
                        DispatchQueue.main.async
                            {
                                if self?.apodItem.url == url.absoluteString
                                {
                                    if let image = UIImage(data: imageData)
                                    {
                                        self?.image = image
                                        
                                        if let handler = self?.successCompletionHandler
                                        {
                                            handler(image)
                                        }
                                    }
                                }
                        }
                    }
                }
        }
    }
}
