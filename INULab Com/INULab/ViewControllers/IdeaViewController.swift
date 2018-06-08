//
//  IdeaViewController.swift
//  INULab
//
//  Created by Cho on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class IdeaViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.shadowColor = UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0).cgColor
        topView.layer.shadowOffset = CGSize.zero
        topView.layer.shadowRadius = 15
        topView.layer.shadowOpacity = 0.6
        initSegmentControl(index: 0)
        printFonts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//SegmentationController
extension IdeaViewController {
    func initSegmentControl(index: UInt) {
        let control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 72, width: view.bounds.width, height: 57.0),
            titles: ["협업 게시판", "질문 게시판"],
            index: index,
            options: [.backgroundColor(UIColor(red:1, green:1, blue:1, alpha:0.0)),
                      .titleColor(UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)),
                      .selectedTitleColor(UIColor.init(red: 243/255, green: 138/255, blue: 138/255, alpha: 1.0)),
                      .titleFont(UIFont(name: "NanumSquareOTFB", size: 18.0)!),
                      .selectedTitleFont(UIFont(name: "NanumSquareOTFB", size: 18.0)!),
                      .bouncesOnChange(false)]
        )
        let indicatorView = UIView()
        indicatorView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width / 2, height: 4)
        indicatorView.backgroundColor = UIColor.init(red: 243/255, green: 138/255, blue: 138/255, alpha: 1.0)
        indicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        control.addSubviewToIndicator(indicatorView)
        control.addTarget(self, action: #selector(IdeaViewController.whenSegmentChanged(_:)), for: .valueChanged)
        control.tag = 10
        self.view.addSubview(control)
    }
    
    @objc func whenSegmentChanged(_ sender: BetterSegmentedControl) {
        
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("———————————————")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
