//
//  CoopBoardPresent.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
class CoopBoardInfo{
    var thisTitle: String
    var textField: String
    var AuthorId: String
    var MaxPpl: String
    var nowPpl: Int
    var textNum: Int
    var thisTag: String
    
    init(coopTitle: String, field: String, id: String, maxPeople: String, nowPeople: Int, titleNum: Int, tag: String){
        thisTitle = coopTitle
        textField = field
        AuthorId = id
        MaxPpl = maxPeople
        nowPpl = nowPeople
        textNum = titleNum
        thisTag = tag
    }
}
