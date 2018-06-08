//
//  LabCalendar.swift
//  INULab
//
//  Created by Cho on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation

class LabCalendar{
    var labName: String?
    var eventName: String?
    var date: Date?
    var startTime: String?
    var content: String?
    
    init(labName: String, eventName: String, date: Date, startTime: String, content: String) {
        self.labName = labName
        self.eventName = eventName
        self.date = date
        self.startTime = startTime
        self.content = content
    }
}
