import UIKit
import BetterSegmentedControl

class CultureViewController: UIViewController {
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var segmentedControlView: UIView!
    @IBOutlet weak var RoomCollectionView: UICollectionView!
    @IBOutlet weak var DvdCollecionView: UICollectionView!
    
    var coopInfo: [CoopBoardInfo] = []
    var questInfo: [QBoardInfo] = []
    var indexOfSegment: UInt = 1
    var whichIndex: Int = 0
    
    
    // MARK: - Examples
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DvdCollecionView.dataSource = self
        DvdCollecionView.delegate = self
        RoomCollectionView.dataSource = self
        RoomCollectionView.delegate = self
        let model = NetworkModel(self)
        model.getCoop()
        let model2 = NetworkModel(self)
        model2.getQ()
        reloadInputViews()
        // Control 5: Adding custom subview to Indicator
        let indicatorControl = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 72.0, width: view.bounds.width, height: 57.0),
            titles: ["협업 게시판", "질문 게시판"],
            index: 0, options: [.backgroundColor(.white),
                                .titleColor(.lightGray),
                                .indicatorViewBorderColor(.lightGray),
                                .selectedTitleColor(UIColor(red:129/255, green:132/255, blue:243/255, alpha:1.00)),
                                .bouncesOnChange(false),
                                .panningDisabled(false)])
        indicatorControl.autoresizingMask = [.flexibleWidth]
        let customSubview = UIView(frame: CGRect(x: 0, y: 45, width: 207, height: 4.0))
        customSubview.backgroundColor = UIColor(red:129/255, green:132/255, blue:243/255, alpha:1.00)
        customSubview.layer.cornerRadius = 2.0
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        indicatorControl.addTarget(self, action: #selector(CultureViewController.whenSegmentChanged(_:)), for: .valueChanged)
        indicatorControl.addSubviewToIndicator(customSubview)
        view.addSubview(indicatorControl)
    }
    
    @objc func whenSegmentChanged(_ sender: BetterSegmentedControl) {
        for view in self.segmentedControlView.subviews {
            if view.tag == 10 {
                view.removeFromSuperview()
            }
        }
        if sender.index == 0{
            RoomCollectionView.isHidden = false
            DvdCollecionView.isHidden = true
            whichIndex = 0
            self.reloadInputViews()
            
        }
        else{
            RoomCollectionView.isHidden = true
            DvdCollecionView.isHidden = false
            whichIndex = 1
             self.reloadInputViews()
        }
    }
    // MARK: - Action handlers
    /* @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
     if sender.index == 0 {
     print("Turning lights on.")
     view.backgroundColor = .white
     }
     else {
     print("Turning lights off.")
     view.backgroundColor = .darkGray
     }
     }
     */
    /*@IBAction func segmentedControl1ValueChanged(_ sender: BetterSegmentedControl) {
     print("The selected index is \(sender.index) and the title is \(sender.titles[Int(sender.index)])")
     }*/
    override func viewWillAppear(_ animated: Bool) {
        let model = NetworkModel(self)
        model.getCoop()
        let model2 = NetworkModel(self)
        model2.getQ()
        
        reloadInputViews()
    }
    
    @IBAction func writeB(_ sender: UIButton){
        
        if whichIndex == 0{
            print("됐다")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addCoop") as! AddCoopViewController
            print("이거도 문제가 없다")
            self.present(vc, animated: true)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addQ") as! AddQViewController
            self.present(vc, animated: true)
            
        }
        
    }
    
}
/*
 }
 
 }
 
 
 
 extension CultureViewController {
 func initSegmentControl(index: UInt) {
 let indicatorControl = BetterSegmentedControl(
 frame: CGRect(x: 0.0, y: 72.0, width: view.bounds.width, height: 57.0),
 titles: ["방 개수", "DVD목록"],
 index: 0, options: [.backgroundColor(.white),
 .titleColor(.lightGray),
 .indicatorViewBorderColor(.lightGray),
 .selectedTitleColor(UIColor(red:84/255, green:124/255, blue:227/255, alpha:1.00)),
 .bouncesOnChange(false),
 .panningDisabled(false)])
 indicatorControl.autoresizingMask = [.flexibleWidth]
 let customSubview = UIView(frame: CGRect(x: 0, y: 45, width: 207, height: 4.0))
 customSubview.backgroundColor = UIColor(red:84/255, green:124/255, blue:227/255, alpha:1.00)
 customSubview.layer.cornerRadius = 2.0
 customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
 indicatorControl.addTarget(self, action: #selector(CultureViewController.whenSegmentChanged(_:)), for: .valueChanged)
 indicatorControl.tag = 10
 indicatorControl.addSubviewToIndicator(customSubview)
 view.addSubview(indicatorControl)
 }
 @objc func whenSegmentChanged(_ sender: BetterSegmentedControl) {
 for view in self.segmentedControlView.subviews {
 if view.tag == 10 {
 view.removeFromSuperview()
 }
 }
 indexOfSegment = sender.index
 initSegmentControl(index: sender.index)
 collectionView.selectItem(at: [Int(sender.index), 0], animated: true, scrollPosition: .centeredHorizontally)
 }
 
 
 }
 */

extension CultureViewController : NetworkCallback{
 
    
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
                    let obj = CoopBoardInfo.init(coopTitle: thisTitle, field: textField, id: AuthorId, maxPeople: maxPpl, nowPeople: nowPpl, titleNum: textNum, tag: thisTag)
                    
                    temp.append(obj)
                
                }
                print("dd")
                self.coopInfo = temp
                print(coopInfo)
            }
            
            else{
                print("ss")
            }
        
        }
        else if code == "question" {
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
        self.DvdCollecionView.reloadData()
        self.RoomCollectionView.reloadData()
    }
    func networkFail(code: String) {
        if(code == "error") {
            print("실패하였습니다.")
            
        }
    }
    
}

extension CultureViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.RoomCollectionView{
            print("coopInfo의 갯수는\(coopInfo.count)")
            
            return coopInfo.count
        }
        else{
            return questInfo.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.RoomCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CultureCollectionViewCell", for: indexPath) as! CultureCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
            cell.layer.cornerRadius = 5
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowRadius = 1.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell.layer.shadowOpacity = 0.4
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 5).cgPath
           
            if coopInfo.count != 0{
                let maxNumber: Int? = Int(coopInfo[indexPath.row].MaxPpl)
                var rest: Int = maxNumber! - coopInfo[indexPath.row].nowPpl
            cell.Title.text =  coopInfo[indexPath.row].thisTitle
            cell.aName.text = coopInfo[indexPath.row].AuthorId
            cell.conSummery.text = coopInfo[indexPath.row].textField
                cell.rest.text = "남은 팀 \(rest)"
            }
        return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Culture2CollectionViewCell", for: indexPath) as! Culture2CollectionViewCell
            cell.backgroundColor = UIColor.white
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
           
            cell.layer.cornerRadius = 5
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowRadius = 1.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell.layer.shadowOpacity = 0.4
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 5).cgPath
 
            cell.aName.text = questInfo[indexPath.row].QAuthor
            cell.atag.text = questInfo[indexPath.row].QTag
            cell.title.text = questInfo[indexPath.row].QTitle
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if collectionView == RoomCollectionView{
            print("selected")
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "testBoard") as? BoardUIVViewController {
                CoopBoard.shared.boardNum = coopInfo[indexPath.row].textNum
                CoopBoard.shared.tag = coopInfo[indexPath.row].thisTag
                CoopBoard.shared.author = coopInfo[indexPath.row].AuthorId
                CoopBoard.shared.content = coopInfo[indexPath.row].textField
                CoopBoard.shared.title = coopInfo[indexPath.row].thisTitle
                CoopBoard.shared.maxNum = coopInfo[indexPath.row].MaxPpl
                CoopBoard.shared.minNum = coopInfo[indexPath.row].nowPpl
                self.present(vc, animated: true, completion: nil)
            }
        }
        else if collectionView == DvdCollecionView{
            print("selected")
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "questBoard") as? QuestViewController {
                QuestionBoard.shared.author = questInfo[indexPath.row].QAuthor
                QuestionBoard.shared.boardNum = questInfo[indexPath.row].QTextNum
                QuestionBoard.shared.content = questInfo[indexPath.row].QContent
                QuestionBoard.shared.tag = questInfo[indexPath.row].QTag
                QuestionBoard.shared.title = questInfo[indexPath.row].QTitle
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
   
    
    
}
