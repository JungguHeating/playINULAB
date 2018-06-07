//
//  CalendarViewController.swift
//  INU_Lab
//
//  Created by 동균 on 2018. 6. 7..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarCell: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.clipsToBounds = true
        self.calendar.appearance.eventDefaultColor = UIColor(red: 255/255.0, green: 183/255.0, blue: 154/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
