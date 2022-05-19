//
//  HomeViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/12.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    let bannerImages : [UIImage] = [UIImage(named: "banner1")!, UIImage(named: "banner2")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        registerNib()
        // Do any additional setup after loading the view.
    }
    
    private func registerNib() {
        let nibName = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
        bannerCollectionView.register(nibName, forCellWithReuseIdentifier: "bannerCell")
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
        cell.bannerImage.image = bannerImages[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: bannerCollectionView.frame.size.width  , height:  bannerCollectionView.frame.height)
        }
}

