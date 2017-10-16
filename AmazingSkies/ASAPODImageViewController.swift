//
//  ASAPODImageViewController.swift
//  AmazingSkies
//
//  Created by Oded Golden on 24/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import UIKit

class ASAPODImageViewController: UIViewController
{
    
    @IBOutlet weak var scrollView: UIScrollView!
        {
        didSet
        {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    var imageURL : URL?
    {
        didSet
        {
            image = nil
            if view.window != nil
            {
                fetchImage()
            }
        }
    }
    
    private func fetchImage()
    {
        if let url = imageURL
        {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents
            {
                image = UIImage(data: imageData)
            }
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image : UIImage?
    {
        get
        {
            return imageView.image
        }
        set
        {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if image == nil
        {
            fetchImage()
        }
    }
}

extension ASAPODImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imageView
    }
}

