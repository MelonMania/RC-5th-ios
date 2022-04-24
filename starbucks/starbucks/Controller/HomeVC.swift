//
//  ViewController.swift
//  starbucks
//
//  Created by RooZin on 2022/04/20.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var upperHeaderView: UIView!
    @IBOutlet weak var userCardView: UIView!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let MaxTopHeight : CGFloat = 422
    let MinTopHeight : CGFloat = 30 + UIApplication.shared.statusBarFrame.height
    
    let eventImage : [String] = ["What'New1","What'New2","What'New3","What'New4","What'New5","What'New6"]
    let popUpBoard = UIStoryboard(name: "PopUpView", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardShadow()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if  UserDefaults.standard.bool(forKey: "pop") == true {
            guard let popUpView = popUpBoard.instantiateViewController(withIdentifier: "popUpView") as? PopUpVC else { return }
            popUpView.modalPresentationStyle = .fullScreen
            self.present(popUpView, animated: false)
        }
    }
    
    func setCardShadow() {
        self.userCardView.layer.shadowColor = UIColor.black.cgColor
        self.userCardView.layer.masksToBounds = false
        self.userCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.userCardView.layer.shadowRadius = 8
        self.userCardView.layer.shadowOpacity = 0.3
    }
}

extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //현재 스크롤의 위치 (최상단 = 0)
        let y: CGFloat = scrollView.contentOffset.y
        
        //변경될 최상단 뷰의 높이
        let ModifiedTopHeight: CGFloat = viewTopHeight.constant - y
        
        // *** 변경될 높이가 최댓값을 초과함
        if(ModifiedTopHeight > MaxTopHeight)
        {
            viewTopHeight.constant = MaxTopHeight
        }
        else if(ModifiedTopHeight < MinTopHeight)
        {
            viewTopHeight.constant = MinTopHeight
        }
        else
        {
            viewTopHeight.constant = ModifiedTopHeight
            scrollView.contentOffset.y = 0
        }
    }
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as?
                eventCollectionViewCell else {
            return eventCollectionViewCell()
        }
        
        cell.buttonView.imageView?.image = UIImage(named: eventImage[indexPath.row])
        return cell
    }
    
}
