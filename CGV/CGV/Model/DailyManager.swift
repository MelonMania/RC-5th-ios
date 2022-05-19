//
//  DailyManager.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import Foundation
import Alamofire

protocol DailyManagerDelegate {
    func updateDailyBoxOffice(_ data : DailyBoxOffice)
}

struct DailyManager {
    let key = "fa99b85f1022b776c70c01a90c597c9c"
    
    var delegate : DailyManagerDelegate?
    
    func loadDailyBoxOffice() {
        let URL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=20220512"
        
        AF.request(URL, method: .get).responseJSON { response in
            print("response: \(response)")
            var daily : DailyBoxOffice
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                case .success:
                    daily = try decoder.decode(DailyBoxOffice.self, from: response.data!)
                    delegate?.updateDailyBoxOffice(daily)
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
