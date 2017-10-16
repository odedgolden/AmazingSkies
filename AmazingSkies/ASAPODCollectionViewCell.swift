//
//  ASAPODCollectionViewCell.swift
//  AmazingSkies
//
//  Created by Oded Golden on 21/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import UIKit

class ASAPODCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
        {
        didSet
        {
            updateUI()
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
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        updateUI()
    }
    
    override func prepareForReuse()
    {
        self.imageView?.image = nil
    }

    fileprivate func updateUI()
    {
        self.imageView?.image = image
    }
}
