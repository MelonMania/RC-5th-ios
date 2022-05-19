//
//  AddProductViewController.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/30.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var selectImageVIew: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    let alertController = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func enrollAlertEvent() {
        let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.openAlbum() // 아래에서 설명 예정.
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
            self.openCamera() // 아래에서 설명 예정.
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        self.alertController.addAction(photoLibraryAlertAction)
        self.alertController.addAction(cameraAlertAction)
        self.alertController.addAction(cancelAlertAction)
        guard let alertControllerPopoverPresentationController
                = alertController.popoverPresentationController
        else {return}
        prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    @objc func tappedUIImageView(_ gesture: UITapGestureRecognizer) {
            self.present(alertController, animated: true, completion: nil)
    }
    
    func addGestureRecognizer() {
            let tapGestureRecognizer
      = UITapGestureRecognizer(target: self,
                               action: #selector(self.tappedUIImageView(_:)))
            self.selectImageVIew.addGestureRecognizer(tapGestureRecognizer)
            self.selectImageVIew.isUserInteractionEnabled = true
    }
    
}

extension AddProductViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController =
            self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect
            = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            selectImageVIew?.image = image
        }
        else {
            print("error detected in didFinishPickinMediaWithInfo method")
        }
        dismiss(animated: true, completion: nil) // 반드시 dismiss 하기.
    }
    
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: false, completion: nil)
    }
    
    func openCamera() {
           if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
               self.imagePickerController.sourceType = .camera
               present(self.imagePickerController, animated: false, completion: nil)
           }
           else {
               print ("Camera's not available as for now.")
           }
       }
}
