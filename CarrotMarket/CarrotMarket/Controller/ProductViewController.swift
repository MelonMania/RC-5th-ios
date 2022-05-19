//
//  ProductViewController.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/30.
//

import UIKit

class ProductViewController: UIViewController {
    
    var productInfo : Product?
    var otherproduct: [OtherProduct] = []
    var heartStatus : Bool!
    
    @IBOutlet weak var otherProductCollectionView: UICollectionView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOther()
        otherProductCollectionView.register(userOtherProductCollectionCell.nib(), forCellWithReuseIdentifier: userOtherProductCollectionCell.identifier)
        otherProductCollectionView.delegate = self
        otherProductCollectionView.dataSource = self
        
        self.productName.text = productInfo?.productName
        self.productPrice.text = productInfo?.productPrice
        self.productImage.image = UIImage(named: (productInfo?.productImage)!)
        setNavigationBar()
        
        heartStatus = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func share() {}
    @IBAction func detail() {}
    @IBAction func home() {}
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func hearAction(_ sender: UIButton) {
        if heartStatus == false {
            heartButton.tintColor = .red
            heartButton.setImage(UIImage (systemName: "heart.fill"), for: UIControl.State.normal)
            heartStatus = true
        }else{
            heartButton.tintColor = .darkGray
            heartButton.setImage(UIImage (systemName: "heart"), for: UIControl.State.normal)
            heartStatus = false
        }
    }
    func setNavigationBar() {
        setLeftButton()
        setRightButton()
    }
    
    func setOther() {
        otherproduct.append(contentsOf: [
            OtherProduct(productImage: "airpodpro", productName: "에어팟 프로", productPrice: "13,000 원"),
            OtherProduct(productImage: "ipadair3", productName: "아이패드 에어3세대", productPrice: "3,000,000 원"),
            OtherProduct(productImage: "case", productName: "아이패드 미니 정품 케이스", productPrice: "500,000 원"),
            OtherProduct(productImage: "iphone11pro", productName: "아이폰 11프로", productPrice: "76,000 원")
        ])
    }
    
}

extension ProductViewController {
    func setRightButton() {
        let shareButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.share), symbolName: "square.and.arrow.up")
        let detailButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.detail), symbolName: "list.bullet")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        self.navigationItem.rightBarButtonItems = [shareButton, spacer, detailButton]
    }
    
    func setLeftButton() {
        let backButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.back), symbolName: "arrow.left")
        let homeButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.home), symbolName: "house")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        self.navigationItem.leftBarButtonItems = [backButton, spacer, homeButton]
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.otherProductCollectionView {
            return otherproduct.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.otherProductCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userOtherProductCollectionCell.identifier, for: indexPath) as? userOtherProductCollectionCell else {
                return UICollectionViewCell()
            }
            
            let productInfo = otherproduct[indexPath.row]
            
            cell.userOtherProductImageView?.image = UIImage(named: productInfo.productImage!)
            cell.userOtherProductNameLabel.text = productInfo.productName
            cell.userOtherProductPriceLabel.text = productInfo.productPrice
            
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
}

extension ProductViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.otherProductCollectionView{
            return CGSize(width: 165, height: 160)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.otherProductCollectionView {
            return UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if collectionView == self.otherProductCollectionView{
                let otherHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "otherProductReusableView", for: indexPath) as! otherProductReusableView
                
                return otherHeaderView
            }else{
                return UICollectionReusableView()
            }
        default: assert(false, "응 아니야")
            
        }
    }
    
    // 헤더 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.otherProductCollectionView {
            return CGSize(width: collectionView.frame.width, height: 112)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}
