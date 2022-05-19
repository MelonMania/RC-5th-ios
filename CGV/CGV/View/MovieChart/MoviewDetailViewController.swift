//
//  MoviewDetailViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import UIKit
import Tabman
import Pageboy

class MoviewDetailViewController: TabmanViewController {

    var viewControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabMan()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviewDetailViewController {
    
    func setUpTabMan() {
        let firstVC = UIStoryboard.init(name: "IngChartView", bundle: nil).instantiateViewController(withIdentifier: "IngChartView") as! IngChartViewController
        let secondVC = UIStoryboard.init(name: "IngMovieView", bundle: nil).instantiateViewController(withIdentifier: "IngMovieView") as! IngMovieViewController
        let thirdVC = ICECONViewController()
        let forthVC = ArtHouseViewController()
        let fifthVC = OnlyCGVViewController()
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        viewControllers.append(forthVC)
        viewControllers.append(fifthVC)
       
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        }
        
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
    }
    
}

//MARK: - PageboyViewControllerDataSource, TMBarDataSource

extension MoviewDetailViewController : PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title : "일간박스오피스")
        case 1:
            return TMBarItem(title : "주간박스오피스")
        case 2:
            return TMBarItem(title : "ICECON")
        case 3:
            return TMBarItem(title : "아트하우스")
        case 4:
            return TMBarItem(title : "오직CGV")
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
