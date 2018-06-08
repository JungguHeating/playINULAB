//
//  AddQViewController.swift
//  INULab
//
//  Created by 김진우 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit

class AddQViewController: UIViewController {

    @IBOutlet weak var qtitle: UITextField!
    @IBOutlet weak var qtag: UITextField!
    @IBOutlet weak var qcontent: UITextView!
    @IBOutlet weak var qwrite: UIBarButtonItem!
    var questInfo: [QBoardInfo] = []
    var lastNum: Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = NetworkModel(self)
        model.getQ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func write(sender: UIBarButtonItem){
        let param:String! = "author=\(self.appDelegate.myLab!.labName!)&title=\(qtitle.text!)&atag=\(qtag.text!)&content=\(qcontent.text!)&textNum=\(lastNum!)"
        print("param\(param!)")
        let model2 = NetworkModel(self)
        model2.giveQuest(param: param)
        
        self.dismiss(animated: true, completion: nil)
    }

}
extension AddQViewController: NetworkCallback{
    
    
    
    
    func networkSuc(resultdata: Any, code: String, tag: Int ) {
        if code == "question" {
            print("성공")
            print(resultdata)
            var temp : [QBoardInfo] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    
                    let QAuthor = item["author"] as? String ?? ""
                    let QTitle = item["title"] as? String ?? ""
                    let QTag = item["atag"] as? String ?? ""
                    let QContent = item["content"] as? String ?? ""
                    let QTextNum = item["textNum"] as? Int ?? 0
                    
                    let obj = QBoardInfo.init(author: QAuthor, title: QTitle, atag: QTag, content: QContent, textNum: QTextNum)
                    
                    temp.append(obj)
                    
                }
                print("dd")
                self.questInfo = temp
                print(questInfo[questInfo.count - 1].QTextNum)
                lastNum = questInfo[questInfo.count - 1].QTextNum + 1
                print(lastNum!)
                print(questInfo[questInfo.count - 1].QTextNum + 1)
            }
                
            else{
                print("ss")
            }
            
        }
        self.reloadInputViews()
    }
    func networkFail(code: String) {
        if(code == "error") {
            print("실패하였습니다.")
            
        }
    }
    
}
