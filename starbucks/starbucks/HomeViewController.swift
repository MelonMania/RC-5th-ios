//
//  HomeViewController.swift
//  starbucks
//
//  Created by RooZin on 2022/04/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var upperHeaderView: UIView!
    @IBOutlet weak var userCardView: UIView!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint! {
        didSet {
            viewTopHeight.constant = MaxTopHeight
        }
    }
    
    let MaxTopHeight : CGFloat = 422
    let MinTopHeight : CGFloat = 30 + UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardShadow()
        // Do any additional setup after loading the view.
    }
    
    
    func setCardShadow() {
        self.userCardView.layer.shadowColor = UIColor.black.cgColor
        self.userCardView.layer.masksToBounds = false
        self.userCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.userCardView.layer.shadowRadius = 8
        self.userCardView.layer.shadowOpacity = 0.3
    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
        if scrollView.contentOffset.y < 0 {
            viewTopHeight.constant = max(abs(scrollView.contentOffset.y), MinTopHeight)
        } else {
            viewTopHeight.constant = MinTopHeight
        }
        
        let totalScroll = scrollView.contentSize.height - scrollView.bounds.size.height;
        let offset = -scrollView.contentOffset.y
        let percentage = offset / totalScroll
        upperHeaderView.alpha = (1 - percentage)
        }
}
