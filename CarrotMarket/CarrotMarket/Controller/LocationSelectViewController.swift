//
//  LocationSelectViewController.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/30.
//

import UIKit

protocol PopoverContentControllerDelegate:class {
    func popoverContent(controller:LocationSelectViewController, didselectItem name:String)
}

class LocationSelectViewController: UIViewController {

    static let identifier = "LocationSelectVC"
    
    @IBOutlet var locselectTableView: UITableView!
    @IBOutlet var locselectTableViewHeight: NSLayoutConstraint!
    
    let locsourceArray = ["주엽동", "대화동", "내 동네 설정하기"]
    static let CELL_RESUE_ID = "POPOVER_CELL_REUSE_ID"
    var delegate:PopoverContentControllerDelegate? //declare a delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locselectTableView.delegate = self
        locselectTableView.dataSource = self
        
        //        super.updateViewConstraints()
        //        self.locselectTableViewHeight?.constant = self.locselectTableView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension LocationSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLocation = locsourceArray[indexPath.row]
        self.delegate?.popoverContent(controller: self, didselectItem: selectedLocation) // 선택된 아이템으로 변경해주기
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LocationSelectViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locsourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: LocationSelectViewController.CELL_RESUE_ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: LocationSelectViewController.CELL_RESUE_ID)
        }
        cell?.textLabel?.text = locsourceArray[indexPath.row]
        //        cell?.textLabel?.textAlignment = .center // 테이블 뷰 내 라벨 정렬
        cell?.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return cell ?? UITableViewCell()
    }
    
    
}
