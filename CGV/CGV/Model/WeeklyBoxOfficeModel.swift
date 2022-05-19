//
//  WeeklyMovie.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import Foundation

struct WeeklyBoxOffice: Decodable {
    let boxOfficeResult: WeeklyBoxOfficeResult
}

struct WeeklyBoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let yearWeekTime : String
    let weeklyBoxOfficeList: [WeeklyMovieData]
}

struct WeeklyMovieData: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}
