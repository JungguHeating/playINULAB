//
//  CoopBoard.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation

class CoopBoard{
    static let shared: CoopBoard = CoopBoard()
    
    var boardNum: Int?
    var author: String?
    var content: String?
    var tag: String?
    var title: String?
    var maxNum: String?
    var minNum: Int?
    
}
