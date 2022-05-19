//
//  IngChartViewController.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import UIKit

class IngChartViewController: UIViewController {
    
    
    @IBOutlet weak var ingChartCV: UICollectionView!
    
    var weeklyManager = WeeklyManager()
    var searchManager = SearchManager()
    
    var weeklyBoxOffice : WeeklyBoxOffice?
    var movieInfo : Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        ingChartCV.delegate = self
        ingChartCV.dataSource = self
        weeklyManager.delegate = self
        searchManager.delegate = self
        weeklyManager.loadWeeklyBoxOffice()
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(weeklyBoxOffice)
        
        // Do any additional setup after loading the view.
    }
    
    private func registerNib() {
        let nibName = UINib(nibName: "IngChartCollectionViewCell", bundle: nil)
        ingChartCV.register(nibName, forCellWithReuseIdentifier: "IngChartCell")
    }
    
}

//MARK: - CollectionView

extension IngChartViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyBoxOffice?.boxOfficeResult.weeklyBoxOfficeList.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = ingChartCV.dequeueReusableCell(withReuseIdentifier: "IngChartCell", for: indexPath) as? IngChartCollectionViewCell else { return UICollectionViewCell()}
        
        
        cell.movieTitle.text = weeklyBoxOffice?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].movieNm ?? "데이터로드 중"
        searchManager.loadMovie(cell.movieTitle.text!)
        
        //cell.movieImage.image = getImage((movieInfo?.items[0].image ?? "https://movie.naver.com/movie/bi/mi/basic.nhn?code=192608"))
        cell.movieImage.image = getImage("https://movie.naver.com/movie/bi/mi/basic.nhn?code=192608")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ingChartCV.frame.width - 80, height: ingChartCV.frame.height)
    }
}

//MARK: -  WeeklyManagerDelegate

extension IngChartViewController : WeeklyManagerDelegate {
    
    func updateWeeklyBoxOffice(_ data: WeeklyBoxOffice) {
        weeklyBoxOffice = data
        print(weeklyBoxOffice!)
    }
}

//MARK: - SearchManagerDelegate

extension IngChartViewController : SearchManagerDelegate {
    func loadMovie(_ searchData: Movie) {
        movieInfo = searchData
    }
}

extension IngChartViewController {
    func getImage(_ url : String) -> UIImage {
        let url = URL(string: url)
        var image : UIImage?
        DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                image = UIImage(data: data!)
            }
        }
        return image ?? UIImage(named: "범죄도시")!
    }
}
