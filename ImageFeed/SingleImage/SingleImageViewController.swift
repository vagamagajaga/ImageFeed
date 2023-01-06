//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Vagan Galstian on 01.01.2023.
//

import Foundation
import UIKit

final class SingleImageViewController:
    UIViewController {
    var image: UIImage! {
        didSet {
            if isViewLoaded {
            imageView.image = image
            } else { return }
        }
    }
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.5
    }
    
    func rescaleAndCenterImageInScroll(image: UIImage) {
        let visibleRectSize = scrollView.bounds.size
        let hScale = visibleRectSize.height
        let wScale = visibleRectSize.width
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        let theoreticalScale = max(hScale, wScale)
        let scale = min(maxZoomScale, max(theoreticalScale,minZoomScale))
            
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
    }
}

