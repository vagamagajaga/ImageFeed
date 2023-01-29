//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Vagan Galstian on 01.01.2023.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? { //заменил форс анрап
        didSet {
            if isViewLoaded {
                imageView.image = image
                guard let image = image else { return } //исправлено после ревью
                rescaleAndCenterImageInScroll(image: image)
            } else { return }
        }
    }
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        imageView.image = image
        guard let image = image else { return } //исправлено после ревью
        rescaleAndCenterImageInScroll(image: image)
    }
    
    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShareButton(_ sender: UIButton) {
        guard let image = image else { return }
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }
    
    private func rescaleAndCenterImageInScroll(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
}

