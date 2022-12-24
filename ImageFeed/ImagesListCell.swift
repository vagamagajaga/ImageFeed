//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Vagan Galstian on 23.12.2022.
//

import Foundation
import UIKit

class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
