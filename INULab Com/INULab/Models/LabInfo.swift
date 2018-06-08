//
//  File.swift
//  INULab
//
//  Created by Cho on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation

class LabInfo{
    var labId: String?
    var labName: String?
    var depName: String
    var professorName: String?
    var studentNames: String?
    var location: String?
    var call: String?
    var isRecruiting: Bool?
    
    init(labId:String, labName: String, depName: String, professorName: String, studentNames: String, location: String, call: String, isRecruiting: Bool) {
        self.labId = labId
        self.labName = labName
        self.depName = depName
        self.professorName = professorName
        self.studentNames = studentNames
        self.location = location
        self.call = call
        self.isRecruiting = isRecruiting
    }
}
