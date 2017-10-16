//
//  ASAPODCollectionViewController.swift
//  AmazingSkies
//
//  Created by Oded Golden on 21/05/2017.
//  Copyright © 2017 Oded Golden. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ASAPODCollectionViewCell"

class ASAPODCollectionViewController: UICollectionViewController {

    let apodDA = ASApodDA()
    var fetchedResultsController : NSFetchedResultsController<ASAPODItem>!
    
    let loadingQueue = OperationQueue()
    var loadingOperations = [IndexPath : ASAPODImageRequest]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let width = collectionView!.frame.width/3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        apodDA.fetchNewImages { (items) in
            print(items.count)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let fetchRequest:NSFetchRequest<ASAPODItem> = ASAPODItem.fetchRequest()
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do
        {
            try fetchedResultsController.performFetch()
            collectionView?.reloadData()
        }
        catch let error
        {
            print(error)
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ASAPODImageViewController
        {
            if let item = sender as? ASAPODItem
            {
                vc.imageURL = URL(string: item.hdurl!)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "Show HD image", sender: fetchedResultsController.object(at: indexPath))
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let apodCell = cell  as? ASAPODCollectionViewCell
        {

            apodCell.apodItem = fetchedResultsController.object(at: indexPath)
            
            return apodCell
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func viewWillLayoutSubviews()
    {
        self.updateViewConstraints()
    }
}


