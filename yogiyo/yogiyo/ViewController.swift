//
//  ViewController.swift
//  yogiyo
//
//  Created by RooZin on 2022/04/15.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var searchView: UIView!
    
    var images = [#imageLiteral(resourceName: "배너1"), #imageLiteral(resourceName: "배너5"), #imageLiteral(resourceName: "배너3"), #imageLiteral(resourceName: "배너4"), #imageLiteral(resourceName: "배너2")]
    var imageViews = [UIImageView]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let xUnit = bannerScrollView.bounds.width
        bannerScrollView.contentSize.width = xUnit * 10
        for i in 0 ..< images.count {
            let newImageView = UIImageView()
            newImageView.frame = CGRect(x: CGFloat(i) * xUnit, y: 0, width: xUnit, height: xUnit)
            newImageView.image = images[i]
            bannerScrollView.addSubview(newImageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerScrollView.delegate = self
        setUpSearchView()
    }
    
    
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: bannerScrollView.bounds.width, height: bannerScrollView.bounds.height)
            imageView.image = images[i]
            bannerScrollView.addSubview(imageView)
            bannerScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setUpSearchView() {
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        searchView.layer.cornerRadius = 10
    }
    
}

