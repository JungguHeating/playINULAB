//
//  AddCoopViewController.swift
//  INULab
//
//  Created by 김진우 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit

class AddCoopViewController: UIViewController {

    @IBOutlet weak var btitle: UITextField!
    @IBOutlet weak var btag: UITextField!
    @IBOutlet weak var maxNum: UITextField!
    @IBOutlet weak var contents: UITextView!
    var coopInfo: [CoopBoardInfo] = []
    var lastNum: Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = NetworkModel(self)
        model.getCoop()

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
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func write(sender: UIBarButtonItem){
        let param:String! = "inputId=\(self.appDelegate.myLab!.labName!)&inputField=\(contents.text!)&maxPeople=\(maxNum.text!)&inputTitle=\(btitle.text!)&titleNum=\(lastNum!)&tag=\(btag.text!)"
        print(param)
        let model2 = NetworkModel(self)
        model2.giveBoard(param: param)
        
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddCoopViewController : NetworkCallback{
    
    
    
    
    func networkSuc(resultdata: Any, code: String, tag: Int) {
        if code == "coop" {
            print("성공")
            print(resultdata)
            var temp : [CoopBoardInfo] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    
                    let thisTitle = item["coopTitle"] as? String ?? ""
                    let textField = item["field"] as? String ?? ""
                    let AuthorId = item["id"] as? String ?? ""
                    let maxPpl = item["maxPeople"] as? String ?? ""
                    let nowPpl = item["nowPeople"] as? Int ?? 0
                    let textNum = item["titleNum"] as? Int ?? 0
                    let thisTag = item["tag"] as? String ?? ""
                    let obj = CoopBoardInfo.init(coopTitle: thisTitle, field: textField, id: AuthorId, maxPeople: maxPpl, nowPeople: nowPpl, titleNum: textNum,tag: thisTag)
                    
                    temp.append(obj)
                    
                }
               
                    self.coopInfo = temp
                print("coopinfo.count : \(coopInfo.count)")
                print("카운트번-1의 배열값 : \(coopInfo[coopInfo.count - 1].textNum)")
                lastNum = coopInfo[coopInfo.count - 1].textNum + 1
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
