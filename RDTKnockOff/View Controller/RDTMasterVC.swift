//
//  ViewController.swift
//  RDTKnockOff
//
//  Created by Anuj Deshmukh on 11/27/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

class RDTMasterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let encodingTopDataKey = "encodedToDoData"
    var topData = RDTTopData()
    var cellHeights: [IndexPath : CGFloat] = [:]
    var selectedIndexPath : IndexPath?
    var isLoadingData : Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        fetchData()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fetchData()
    }
    
    final private func commonInit() {
        restorationIdentifier = String(describing: type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rdtListingDetailView" {
            guard let indexPath = selectedIndexPath else {return}
            let listingDetailVC = segue.destination as! RDTListingDetailVC
            listingDetailVC.listingData = topData.listingArr[indexPath.row]
        }
    }
}

