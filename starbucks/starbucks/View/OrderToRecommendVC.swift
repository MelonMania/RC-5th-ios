//
//  OrderToRecommendVC.swift
//  starbucks
//
//  Created by RooZin on 2022/04/23.
//

import UIKit

class OrderToRecommendVC: UIViewController {

    let imageList : [String] = ["menu1", "menu2", "menu3", "menu4", "menu5", "menu6", "menu7", "menu8", "menu9", "menu10"]
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func navigationSetup() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "추천"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: nil)
    }
    

}

extension OrderToRecommendVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as?   menuCollectionViewCell else {
            return menuCollectionViewCell()
        }
        
        cell.imageView.image = UIImage(named: imageList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            guard let rcView = self.storyboard?.instantiateViewController(withIdentifier: "rcView") as? OrderToRecommendVC else { return }
            self.navigationController?.pushViewController(rcView, animated: true)
        }
    }
    
    
}
