//
//  BoardUIVViewController.swift
//  INULand
//
//  Created by 김진우 on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import UIKit

class BoardUIVViewController: UIViewController {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var goBack: UIButton!
    var indexString: Int?
    var coopInfo: [CoopBoardInfo] = []
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var volunteerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

       indexString = CoopBoard.shared.boardNum
        titleLabel.text = CoopBoard.shared.title
        authorLabel.text = CoopBoard.shared.author
        contentText.text = CoopBoard.shared.content
        tagLabel.text = CoopBoard.shared.tag
        indexLabel.text = "\(indexString!)"
        // Do any additional setup after loading the view.
        let model = NetworkModel(self)
        model.getCoop()
     
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        let maxNumber: Int? = Int(CoopBoard.shared.maxNum!)
        if maxNumber == CoopBoard.shared.minNum{
            volunteerButton.isEnabled = false
        }
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

extension BoardUIVViewController : NetworkCallback{
    
    
    
    
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
                let tempNum: Int = temp.count
                for a in 0 ..< tempNum{
                    if temp[a].textNum ==  CoopBoard.shared.boardNum{
                        
                        self.coopInfo.append(temp[a])
                        break;
                        
                    }
                    
                }
                print("dd")
                
                print(coopInfo)
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

extension BoardUIVViewController {
    @IBAction func volunteer(sender: UIButton){
        let maxNumber: Int? = Int(CoopBoard.shared.maxNum!)
        if maxNumber! > CoopBoard.shared.minNum!{
            self.volunteerButton.isEnabled = true
            CoopBoard.shared.minNum = CoopBoard.shared.minNum! + 1
            print(CoopBoard.shared.minNum!)
            let param :String! = "titleNum=\(CoopBoard.shared.boardNum!)&nowPeople=\(CoopBoard.shared.minNum!)"
            print(param)
            let model = NetworkModel(self)
            model.giveCoop(param: param)
            if maxNumber! == CoopBoard.shared.minNum!{
                self.volunteerButton.isEnabled = false
                self.volunteerButton.setTitle("신청마감", for: .normal)
            }
        }
        else{
            self.volunteerButton.isEnabled = false
            self.volunteerButton.setTitle("신청마감", for: .normal)
        }
    }
    
    
}
