//
//  QuestionBoard.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation

class QuestionBoard{
    static let shared: CoopBoard = CoopBoard()
    
    var qTitle: String?
    var qName: String?
    var qTag: String?
    var qContent: String?
    var qNum: Int?
    
}
