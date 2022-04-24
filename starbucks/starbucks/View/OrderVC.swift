//
//  OrderVC.swift
//  starbucks
//
//  Created by RooZin on 2022/04/22.
//

import UIKit

class OrderVC: UIViewController {
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let imageList : [String] = ["cate1", "cate2", "cate3", "cate4", "cate5", "cate6", "cate7", "cate8", "cate9", ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension OrderVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as?   categoryCollectionViewCell else {
            return categoryCollectionViewCell()
        }
        
        cell.imageView.image = UIImage(named: imageList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "RecommendView", bundle: nil)
            guard let rcView = storyboard.instantiateViewController(withIdentifier: "rcView") as? OrderToRecommendVC else { return }
            self.navigationController?.pushViewController(rcView, animated: true)
        }
    }
    
}
