//
//  ImageHelper.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit


public protocol imageSession {
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath)
}

class ImageHelper:imageSession{
    
    fileprivate let kLazyLoadCellImageViewTag = 1
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!
    
    let imageManager = ImageManager()
    
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as? UIImageView
        imageView?.image = kLazyLoadPlaceholderImage
        imageManager.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView?.image = image
                }
            }
        }
    }
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath , completion: ((_ success: Bool, _ image: UIImage?) -> Void)?) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as? UIImageView
        imageView?.image = kLazyLoadPlaceholderImage
        imageManager.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView?.image = image
                    DispatchQueue.main.async(execute: { completion?(true, image) });
                }
            }
            else {
                DispatchQueue.main.async(execute: { completion?(true, image) });
            }
            
            
        }
    }
    
}
