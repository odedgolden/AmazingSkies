//
//  ASAPODCollectionViewCell.swift
//  AmazingSkies
//
//  Created by Oded Golden on 21/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import UIKit
import AlamofireImage

class ASAPODCollectionViewCell: UICollectionViewCell
{
    // Cache for the thumbnails
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    let container = AppDelegate.persistentContainer
    
    @IBOutlet weak var imageView: UIImageView!
        {
        didSet
        {
            //updateUI()
        }
    }
    
    var image : UIImage?
    {
        didSet
        {
            self.imageView?.image = image
        }
    }
    
    var apodItem : ASAPODItem?
    {
        didSet
        {
            updateUI()
        }
    }

    
    override func prepareForReuse()
    {
        self.imageView?.image = nil
    }

    fileprivate func updateUI()
    {
        // First check if there is any cached image
        if let avatarImage = self.imageCache.image(withIdentifier: (self.apodItem?.id)!)
        {
            self.imageView?.image = avatarImage
        }
        // If not, check fot image in core data
        else if self.apodItem?.thumbnail_image_data != nil
        {
            self.imageView.image = UIImage(data: self.apodItem!.thumbnail_image_data! as Data)
        }
        
        // If no saved image data is to be found - fetch image from url, and save the image
        else if let imageURL = apodItem?.url
        {
            if let url = URL(string: imageURL)
            {
                DispatchQueue.global().async
                    {
                        [weak self] in
                        if let data = try? Data(contentsOf: url)
                        {
                            if (self?.apodItem?.url)! == url.absoluteString
                            {
                                DispatchQueue.main.async
                                    {
                                        let avatarImage = UIImage(data: data)
                                        self?.imageView?.image = avatarImage
                                        if let imageID = self?.apodItem?.id,
                                            avatarImage != nil
                                        {
                                            self?.imageCache.add(avatarImage!, withIdentifier: imageID)
                                            
                                        }
                                }
                                
                                self?.container.performBackgroundTask
                                    {(context) in
                                        ASAPODItem.setThumbnailImageData(id: (self?.apodItem?.id!)!, imageData: data, context: context)
                                }
                            }
                        }
                }
            }
        }
    }
}
