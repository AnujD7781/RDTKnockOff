//
//  RDTMasterVCViewExtension.swift
//  RDTKnockOff
//
//  Created by Anuj Deshmukh on 11/27/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

extension RDTMasterVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: - tableView delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topData.listingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rdtListingCellId", for: indexPath) as! RDTListCell
        cell.setData(listingData: topData.listingArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listingData = topData.listingArr[indexPath.row]
        guard let thumbnailUrl = listingData.thumbnailUrl else {
            return
        }
        if UIApplication.shared.canOpenURL(URL(string: thumbnailUrl)!) {
            selectedIndexPath = indexPath
            performSegue(withIdentifier: "rdtListingDetailView", sender: tableView)
        } else {
            print("can not open thumbnail")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        if indexPath.row == topData.listingArr.count-1 {
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 70.0 }
        return height
    }
}
