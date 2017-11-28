//
//  RDTMasterVCDataExtension.swift
//  RDTKnockOff
//
//  Created by Anuj Deshmukh on 11/27/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

extension RDTMasterVC {
    func fetchData() {
        isLoadingData = true
        topData.fetch { (error) in
            self.isLoadingData = false
            if error == nil {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - State Restoring
    override func encodeRestorableState(with coder: NSCoder) {
        guard isViewLoaded else {
            return
        }
        coder.encode(topData, forKey: "topData")
        coder.encode(tableView.contentOffset.y, forKey: "contentOffsetY")
        coder.encode(cellHeights, forKey:"heights")
        super.encodeRestorableState(with: coder)
        
    }
    
    override func decodeRestorableState(with coder: NSCoder)  {
        assert(isViewLoaded, "We assume the controller is never restored without loading its view first.")
        if let topDataEncodedObj = coder.decodeObject(forKey: "topData") {
            topData = topDataEncodedObj as! RDTTopData
        }
        
        if let topDataEncodedObj = coder.decodeObject(forKey: "contentOffsetY") {
            tableView.contentOffset.y = topDataEncodedObj as! CGFloat
        }
        if let heights = coder.decodeObject(forKey: "heights") {
            cellHeights = heights as! [IndexPath : CGFloat]
        }
        
        if topData.listingArr.count == 0 {
            fetchData()
        }
        super.decodeRestorableState(with: coder)
        
    }
}
