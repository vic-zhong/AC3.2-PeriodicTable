//
//  PeriodicTableCollectionViewController.swift
//  PeriodicTable
//
//  Created by Victor Zhong on 12/21/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit
import CoreData

class PeriodicTableCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    let spacingArray = [0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 0]
    
    var fetchedResultsController: NSFetchedResultsController<Element>!
    
    private let reuseIdentifier = "elementCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName:"ElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        getData()
        initializeFetchedResultsController()
    }
    
    func getData() {
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { data in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]),
                    let returnedElements = jsonData as? [[String:Any]] {
                    
                    let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.privateContext
                    
                    moc.performAndWait {
                        for element in returnedElements {
                            // now it goes in the database
                            let ele = NSEntityDescription.insertNewObject(forEntityName: "Element", into: moc) as! Element
                            ele.populate(from: element)
                        }
                        
                        do {
                            try moc.save()
                            
                            moc.parent?.performAndWait {
                                do {
                                    try moc.parent?.save()
                                }
                                catch {
                                    fatalError("Failure to save context: \(error)")
                                }
                            }
                        }
                        catch {
                            fatalError("Failure to save context: \(error)")
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    func initializeFetchedResultsController() {
        let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.managedObjectContext
        
        let request = NSFetchRequest<Element>(entityName: "Element")
        let numberSort = NSSortDescriptor(key: "number", ascending: true)
        let groupSort = NSSortDescriptor(key: "group", ascending: true)
        request.sortDescriptors = [groupSort, numberSort]
        
//        do {
//            let els = try moc.fetch(request)
//            try fetchedResultsController.performFetch()
//            
//            for el in els {
//                print("\(el.group) \(el.number) \(el.symbol)")
//            }
//        }
//        catch {
//            print("error fetching")
//        }
        
        //
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "group", cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
      let els = try moc.fetch(request)
                        for el in els {
                print("\(el.group) \(el.number) \(el.symbol)")
            }
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = fetchedResultsController.sections else {
            print("No sections found in fetchedResultsController")
            return 0
        }
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            print("No sections found in fetchedResultsController")
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ElementCollectionViewCell
        
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(_ cell: ElementCollectionViewCell, indexPath: IndexPath) {
        let element = fetchedResultsController.object(at: indexPath)
        cell.elementView.symbolLabel.text = element.symbol
        cell.elementView.numLabel.text = String(element.number)
        
//        switch element.group {
//        case 1:
//cell.elementView.bgColor.backgroundColor = .blue
//        case 2:
//cell.elementView.bgColor.backgroundColor = .purple
//        default: break
//        }
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
    
}
