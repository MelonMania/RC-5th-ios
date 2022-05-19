//
//  RootViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import UIKit
import Tabman
import Pageboy

class RootViewController: TabmanViewController {
    
    var viewControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightButton()
        setLeftButton()
        setUpTabMan()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func search() {
        print("Search")
    }
    @IBAction func menu() {}
    @IBAction func alarm() {}
    @IBAction func home() {}
    
}

extension RootViewController {
    func setRightButton() {
        let ticketButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.search), symbolName: "ticket")
        let foodButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.alarm), symbolName: "menucard")
        let menuButton = self.navigationItem.makeSFSymbolButton(self, action: #selector(self.menu), symbolName: "text.justify")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        self.navigationItem.rightBarButtonItems = [menuButton, spacer, foodButton, spacer, ticketButton]
    }
    
    func setLeftButton() {
        let homeButton =  self.navigationItem.makeCustomlButton(self, action: #selector(self.home), imageName: "HomeButton")
        self.navigationItem.leftBarButtonItem = homeButton
    }
}

//MARK: - 탭바 설정

extension RootViewController {
    
    func setUpTabMan() {
        let firstVC = UIStoryboard.init(name: "HomeView", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        let secondVC = EventViewController()
        let thirdVC = TalkViewController()
        let forthVC = FastOrderViewController()
        let fifthVC = GiftShopViewController()
        let sixthVC = EtcViewController()
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        viewControllers.append(forthVC)
        viewControllers.append(fifthVC)
        viewControllers.append(sixthVC)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .flat(color: UIColor.red)
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        bar.buttons.customize { (button) in
            button.tintColor = .white
            button.selectedTintColor = .white
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .white
        addBar(bar, dataSource: self, at: .top)
    }
    
}

//MARK: - PageboyViewControllerDataSource, TMBarDataSource

extension RootViewController : PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title : "홈")
        case 1:
            return TMBarItem(title : "이벤트")
        case 2:
            return TMBarItem(title : "무비톡")
        case 3:
            return TMBarItem(title : "패스트오더")
        case 4:
            return TMBarItem(title : "기프트샵")
        case 5:
            return TMBarItem(title : "@CGV")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
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
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        return barButtonItem
    }
    
    func makeCustomlButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
        
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        return barButtonItem
    }
}
