//
//  QBoard.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation

class QBoardInfo{
    var QAuthor: String
    var QTitle: String
    var QTag: String
    var QContent: String
    var QTextNum: Int
    
    init(author: String, title: String, atag: String, content: String, textNum: Int){
        QAuthor = author
        QTitle = title
        QTag = atag
        QContent = content
        QTextNum = textNum
    }
}
