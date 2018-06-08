//
//  QuestViewController.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 8..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit

class QuestViewController: UIViewController {

    @IBOutlet weak var qtitle: UILabel!
    @IBOutlet weak var qauthor: UILabel!
    @IBOutlet weak var qtag: UILabel!
    @IBOutlet weak var qcontent: UITextView!
    @IBOutlet weak var repleWrite: UITextField!
    @IBOutlet weak var repleButton: UIButton!
    @IBOutlet weak var goBack: UIButton!
    
    var questInfo: [QBoardInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qtitle.text = QuestionBoard.shared.content
        qauthor.text = QuestionBoard.shared.author
        qtag.text = QuestionBoard.shared.tag
        qcontent.text = QuestionBoard.shared.content
        
        let model = NetworkModel(self)
        model.getQ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(){
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

}

extension QuestViewController: NetworkCallback{
   
    
    
    
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
                print(questInfo)
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
extension QuestViewController{
    
}
