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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let homeCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(homeCell, forCellReuseIdentifier: "HomeTableViewCell")
        setRightButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBtnFloating()
    }
    
    @IBAction func search() {}
    @IBAction func menu() {}
    @IBAction func alarm() {}
    
}

extension HomeViewController {
    func setPopOver() {
        
    }
    
    func setRightButton() {
        let searchButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.search), symbolName: "magnifyingglass")
        let menuButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.menu), symbolName: "menucard")
        let alarmButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.alarm), symbolName: "bell")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        self.navigationItem.rightBarButtonItems = [alarmButton, spacer, menuButton, spacer, searchButton]
    }
    
    private func setupBtnFloating() {

            let hoverConfiguration = HoverConfiguration(
                image: UIImage(systemName: "plus"),
                color: HoverColor.color(UIColor.orange),
                size: 45
            )
       

            let items = [
                HoverItem(title: "photo", image: UIImage(systemName: "photo")!) { [weak self] in
                    print("photo tap event")
                },
                HoverItem(title: "switch", image: UIImage(systemName: "switch.2")!) { [weak self] in
                    print("switch tap event")
                },
                HoverItem(title: "flash", image: UIImage(systemName: "bolt.fill")!) { [weak self] in
                    print("flash tap event")
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        cell.imageView?.image = UIImage(named: "독일군")
        cell.productName.text = "adasd"
        cell.address.text = "asdad"
        cell.price.text = "123123"
        
        return cell
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
