//
//  SearchManager.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import Foundation
import Alamofire

protocol SearchManagerDelegate {
    func loadMovie(_ searchData : Movie)
}

struct SearchManager {
    
    let key = "fa99b85f1022b776c70c01a90c597c9c"
    
    var delegate : SearchManagerDelegate?
    
    func loadMovie(_ title : String) {
        let baseURL = "https://openapi.naver.com/v1/search/movie.json"
        
        let headers: HTTPHeaders = [
                "X-Naver-Client-Id": "aRpAl_ge5p3PCdK3CFe_",
                "X-Naver-Client-Secret": "qZEccDgUwG",
            ]
        
       let parameters: Parameters = [
               "query": title,
               "display": 10,
               "yearfrom": 2000,
               "yearto": 2022,
           ]
        
        AF.request(baseURL, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            print("response: \(response)")
            var searchedMovie : Movie
            do {
                let decoder = JSONDecoder()
                switch (response.result) {
                case .success:
                    searchedMovie = try decoder.decode(Movie.self, from: response.data!)
                    delegate?.loadMovie(searchedMovie)
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
