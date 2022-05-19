//
//  HomeViewController.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/25.
//

import UIKit
import Hover

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    let products : [Product] = [Product(productImage: "물건1", productName: "물건1", address : "연무동", productPrice: "10000원"), Product(productImage: "물건2", productName: "물건2", address : "연무동", productPrice: "10000원"), Product(productImage: "물건3", productName: "물건3", address : "연무동", productPrice: "10000원"), Product(productImage: "물건4", productName: "물건4", address : "연무동", productPrice: "10000원"), Product(productImage: "물건5", productName: "물건5", address : "연무동", productPrice: "10000원"), Product(productImage: "물건6", productName: "물건6", address : "연무동", productPrice: "10000원"), Product(productImage: "물건7", productName: "물건7", address : "연무동", productPrice: "10000원"), Product(productImage: "물건8", productName: "물건8", address : "연무동", productPrice: "10000원"), Product(productImage: "물건9", productName: "물건9", address : "연무동", productPrice: "10000원"), Product(productImage: "물건10", productName: "물건10", address : "연무동", productPrice: "10000원"), Product(productImage: "물건11", productName: "물건11", address : "연무동", productPrice: "10000원")]
    
    var popOverButton = UIBarButtonItem(title: "연무동 ⏑", style: .plain, target: self, action: #selector(popOver))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let homeCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(homeCell, forCellReuseIdentifier: "HomeTableViewCell")
        setRightButton()
        setLeftButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBtnFloating()
    }
    
    @IBAction func search() {
        print("Search")
    }
    @IBAction func menu() {}
    @IBAction func alarm() {}
    @IBAction func popOver(_ sender : Any) {
        //get the button frame
        /* 1 */
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        contentView.backgroundColor = UIColor.clear
        
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        let storyboard = UIStoryboard(name: "LocationSelectView", bundle: nil)
        
        /* 2 */
        //Configure the presentation controller
        let locationpopoverController = storyboard.instantiateViewController(withIdentifier: "LocationSelectVC") as? LocationSelectViewController
        locationpopoverController?.modalPresentationStyle = .popover
        locationpopoverController?.preferredContentSize = CGSize(width:300, height:150) // 모달 사이즈 지정
        
        /* 3 */
        if let popoverPresentationController = locationpopoverController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            
            locationpopoverController?.delegate = self
            
            if let popoverController = locationpopoverController {
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - VC 추가 버튼

extension HomeViewController {
    
    func setRightButton() {
        let searchButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.search), symbolName: "magnifyingglass")
        let menuButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.menu), symbolName: "text.justify")
        let alarmButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.alarm), symbolName: "bell")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        self.navigationItem.rightBarButtonItems = [alarmButton, spacer, menuButton, spacer, searchButton]
    }
    
    func setLeftButton() {
        
        popOverButton.tintColor = .black
        popOverButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal) // 폰트 설정
        self.navigationItem.leftBarButtonItem = popOverButton
    }
    
    private func setupBtnFloating() {
        
        let hoverConfiguration = HoverConfiguration(
            image: UIImage(systemName: "plus"),
            color: HoverColor.color(UIColor.orange),
            size: 45
        )
        
        hoverConfiguration.image?.withTintColor(.white)
        
        
        let items = [
            HoverItem(title: "내 물건 팔기", image: UIImage(systemName: "shippingbox")!) {
                guard let addView = self.storyboard!.instantiateViewController(withIdentifier: "addView") as? AddProductViewController else { return }
                
                addView.hidesBottomBarWhenPushed = true // push시 탭 바 숨기기
                self.navigationController?.pushViewController(addView, animated: true)
            }
        ]
        
        let hoverView = HoverView(with: hoverConfiguration, items: items)
        
        view.addSubview(hoverView)
        hoverView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                hoverView.topAnchor.constraint(equalTo: view.topAnchor),
                hoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        let currentProduct = products[indexPath.row]
        
        cell.imageView?.image = UIImage(named: currentProduct.productImage!)
        cell.productName.text = currentProduct.productName
        cell.address.text = currentProduct.address
        cell.price.text = currentProduct.productPrice
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductView", bundle: nil)
        guard let productView = storyboard.instantiateViewController(withIdentifier: "ProductView") as? ProductViewController else { return }
        productView.productInfo = products[indexPath.row]
        
        productView.hidesBottomBarWhenPushed = true // push시 탭 바 숨기기
        self.navigationController?.pushViewController(productView, animated: true)
    }
}

//MARK: - UINavigationItem

extension UINavigationItem {
    func makeSFSymbolButton(_ target: Any?, action: Selector, symbolName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: symbolName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
        
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return barButtonItem
    }
}

//MARK: - UI View

extension UIView {
    func setFloatingStyle() {
        setShadow(color: .black, alpha: 0.2, xPoint: 0, yPoint: 6, blur: 10, spread: 0)
    }
    
    func setShadow(color: UIColor = .black,
                   alpha: Float,
                   xPoint: CGFloat,
                   yPoint: CGFloat,
                   blur: CGFloat,
                   spread: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: xPoint, height: yPoint)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let diffx = -spread
            let rect = layer.bounds.insetBy(dx: diffx, dy: diffx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

//MARK: - 팝업

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    // Present 스타일
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

extension HomeViewController:PopoverContentControllerDelegate {
    func popoverContent(controller: LocationSelectViewController, didselectItem name: String) {
        popOverButton.title = name
    }
}
