//
//  IngMovieViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import UIKit

class IngMovieViewController: UIViewController {

    @IBOutlet weak var ingMovieCV: UICollectionView!
    
    var dailyManager = DailyManager()
    var dailyBoxOffice : DailyBoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        ingMovieCV.delegate = self
        ingMovieCV.dataSource = self
        dailyManager.delegate = self
        dailyManager.loadDailyBoxOffice()
        // Do any additional setup after loading the view.
    }

    private func registerNib() {
        let nibName = UINib(nibName: "IngMovieCollectionViewCell", bundle: nil)
        ingMovieCV.register(nibName, forCellWithReuseIdentifier: "IngMovieCell")
    }
}

extension IngMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = ingMovieCV.dequeueReusableCell(withReuseIdentifier: "IngMovieCell", for: indexPath) as? IngMovieCollectionViewCell else { return UICollectionViewCell()}
        
        cell.movieImage.image = UIImage(named: "범죄도시")!
        cell.movieTitle.text = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm ?? "데이터로드중"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ingMovieCV.frame.width - 80, height: ingMovieCV.frame.height)
    }
}

//MARK: -  WeeklyManagerDelegate

extension IngMovieViewController : DailyManagerDelegate {
    
    func updateDailyBoxOffice(_ data: DailyBoxOffice) {
        dailyBoxOffice = data
    }
    
    
}
