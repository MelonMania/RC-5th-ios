//
//  WeeklyManager.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import Foundation
import Alamofire

protocol WeeklyManagerDelegate {
    func updateWeeklyBoxOffice(_ data : WeeklyBoxOffice)
}

struct WeeklyManager {
    
    let key = "fa99b85f1022b776c70c01a90c597c9c"
    
    var delegate : WeeklyManagerDelegate?
    
    func loadWeeklyBoxOffice() {
        let URL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=\(key)&targetDt=20220501"
        
        AF.request(URL, method: .get).responseJSON { response in
            print("response: \(response)")
            var weekly : WeeklyBoxOffice
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                case .success:
                    weekly = try decoder.decode(WeeklyBoxOffice.self, from: response.data!)
                    delegate?.updateWeeklyBoxOffice(weekly)
                case .failure(let error):
                    print("errorCode: \(error._code)")
                    print("errorDescription: \(error.errorDescription!)")
                }
            } catch let parsingError {
                print("Error : ", parsingError)
            }
        }.resume()
    }
}
