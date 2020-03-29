//
//  DataSource.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    fileprivate let landscapeReuseIdentifier = "LandscapeTableViewCell"
}

class FeedsDataSource : GenericDataSource<ListModel>, UITableViewDataSource {
    
    let imageHelper = ImageHelper()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as! LandscapeTableViewCell
        let feedsValue = self.data.value[indexPath.row]
        cell.feedsValue = feedsValue
        if feedsValue.imageRef != ""  && feedsValue.imageRef != "N/A"{
            imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL:feedsValue.imageRef, atIndexPath: indexPath){ (success, image) -> Void in
                if success && image != nil {
                    cell.thumbnailImage.isHidden = false
                    cell.imageWidthConstraint.constant =  126//60
                    //cell.imageHeightConstraint.constant = 126
                }else{
                    cell.thumbnailImage.isHidden = true
                    cell.imageWidthConstraint.constant = 0
                    //cell.imageHeightConstraint.constant = 0
                }
            }
        }else{
            cell.thumbnailImage.isHidden = true
            cell.imageWidthConstraint.constant = 0
            //cell.imageHeightConstraint.constant = 0
        }
        return cell
    }
}
