//
//  PopUpVC.swift
//  starbucks
//
//  Created by RooZin on 2022/04/23.
//

import UIKit

class PopUpVC: UIViewController {
    
    let homeStoryBoard = UIStoryboard(name: "HomeView", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func foreverClose(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "pop")
        self.dismiss(animated: false)
    }
    
    @IBAction func close(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "pop")
        self.dismiss(animated: false)
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
