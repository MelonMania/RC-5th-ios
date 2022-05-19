//
//  MidViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import UIKit
import Tabman
import Pageboy

class MidViewController: TabmanViewController {

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

extension MidViewController {
    
    func setUpTabMan() {
        let firstVC = UIStoryboard.init(name: "MovieChartView", bundle: nil).instantiateViewController(withIdentifier: "MovieChartVC") as! MovieChartViewController
        
        let secondVC = UIStoryboard.init(name: "ComingSoonView", bundle: nil).instantiateViewController(withIdentifier: "ComingSoonVC") as! ComingSoonViewController
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
       
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        bar.indicator.weight = .custom(value: 0)
        bar.indicator.tintColor = .clear
        addBar(bar, dataSource: self, at: .top)
    }
    
}

//MARK: - PageboyViewControllerDataSource, TMBarDataSource

extension MidViewController : PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title : "무비차트")
        case 1:
            return TMBarItem(title : "상영예정")
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
