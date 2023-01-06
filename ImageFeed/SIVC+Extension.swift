//
//  SIVC+Extension.swift
//  ImageFeed
//
//  Created by Vagan Galstian on 05.01.2023.
//

import Foundation
import UIKit

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
