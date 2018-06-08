//
//  NetworkModel.swift
//  INULab
//
//  Created by Cho on 2018. 6. 7..
//  Copyright © 2018년 Cho. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkModel{
    private let schURL = "https://playground-e61bc.firebaseapp.com/calendar/schCalendar"
    private let labURL = "https://playground-e61bc.firebaseapp.com/calendar/labCalendar"
    private let infoURL = "https://playground-e61bc.firebaseapp.com/labStatus"
    
    var view : NetworkCallback
    
    init(_ view: NetworkCallback) {
        self.view = view
    }
    
    func getSchCal() {
        Alamofire.request(schURL, method: .get, parameters: nil, headers: nil) .responseJSON
            { res in
            
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "SCH", tag: 10)
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "error")
            }
        }
    }
    
    func getLabCal(labName: String) {
        Alamofire.request(labURL+"?labName=\(labName)", method: .get, parameters: nil, headers: nil) .responseJSON
            { res in
            
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "LAB", tag: 10)
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "error")
            }
        }
    }
    
    func getLabInfo() {
        print(labURL)
        Alamofire.request(infoURL, method: .get, parameters: nil, headers: nil) .responseJSON
            { res in
                
                switch res.result{
                case .success(let item):
                    self.view.networkSuc(resultdata: item, code: "INFO", tag: 10)
                    break
                case .failure(let error):
                    print(error)
                    self.view.networkFail(code: "error")
                }
        }
    }
    
    func postDeleteLabCal(eventName: String){
        print(labURL+"/delete?eventName=\(eventName)")
        let url = URL.init(string: labURL+"/delete?eventName=\(eventName)")
        Alamofire.request(url!, method: .post, parameters: nil, headers: nil) .responseJSON
            { res in
                
                switch res.result{
                case .success(let item):
                    self.view.networkSuc(resultdata: item, code: "DELETE", tag: 10)
                    break
                case .failure(let error):
                    print(error)
                    self.view.networkFail(code: "error")
                }
        }
    }
    
    func postEventLabCal(labName: String, eventName: String, date: String, startTime:String, content: String){
        print(labURL+"?labId=\(labName)")
        let url = labURL+"?labName=\(labName)&eventName=\(eventName)&date=\(date)&startTime=\(startTime)&content=\(content)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(encoded, method: .post, parameters: nil, headers: nil) .responseJSON
            { res in
                switch res.result{
                case .success(let item):
                    self.view.networkSuc(resultdata: item, code: "ADD", tag: 10)
                    break
                case .failure(let error):
                    print(error)
                    self.view.networkFail(code: "error")
                }
                
        }
    }
    
    func getCoop() {
        let url = URL.init(string: "https://playground-e61bc.firebaseapp.com/coopBoard")
        Alamofire.request(url!, method: .get, parameters: nil, headers: nil) .responseJSON { res in
            
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "coop", tag: 11)
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "error")
            }
        }
    }
    func giveCoop(param: String) {
        let url = "https://playground-e61bc.firebaseapp.com/coopBoard/button?\(param)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(encoded, method: .post, parameters: nil, headers: nil).responseJSON
            { res in
                switch res.result {
                case .success(let item):
                    print("success")
                    if let tf = item as? Bool {
                        if tf {
                            self.view.networkSuc(resultdata: item, code: "reservationSuccess", tag: 12)
                        }
                        else {
                            self.view.networkSuc(resultdata: item, code: "reservationFail", tag: 13)
                        }
                    }
                    break
                case .failure(let error):
                    print("에러남")
                    //self.view.networkFail(code: "giveCoop")
                    break
                }
        }
    }
    func getQ() {
        let url = URL.init(string: "https://playground-e61bc.firebaseapp.com/questionBoard")
        Alamofire.request(url!, method: .get, parameters: nil, headers: nil) .responseJSON { res in
            
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "question", tag: 14)
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "error")
            }
        }
    }
    func giveBoard(param: String) {
        let stringUrl = "https://playground-e61bc.firebaseapp.com/coopBoard/add?\(param)"
        let encoded = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("encoded\(encoded)")
        Alamofire.request(encoded, method: .post, parameters: nil, headers: nil).responseJSON
            { res in
                switch res.result {
                case .success(let item):
                    print("success")
                    if let tf = item as? Bool {
                        if tf {
                            self.view.networkSuc(resultdata: item, code: "reservationSuccess", tag: 12)
                        }
                        else {
                            self.view.networkSuc(resultdata: item, code: "reservationFail", tag: 13)
                        }
                    }
                    break
                case .failure(let error):
                    print("에러남")
                    //self.view.networkFail(code: "giveCoop")
                    break
                }
        }
    }
    
    func giveQuest(param: String) {
        let stringUrl = "https://playground-e61bc.firebaseapp.com/questionBoard/add?\(param)"
        let encoded = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("encoded\(encoded)")
        Alamofire.request(encoded, method: .post, parameters: nil, headers: nil).responseJSON
            { res in
                switch res.result {
                case .success(let item):
                    print("success")
                    if let tf = item as? Bool {
                        if tf {
                            self.view.networkSuc(resultdata: item, code: "reservationSuccess", tag: 12)
                        }
                        else {
                            self.view.networkSuc(resultdata: item, code: "reservationFail", tag: 13)
                        }
                    }
                    break
                case .failure(let error):
                    print("에러남")
                    //self.view.networkFail(code: "giveCoop")
                    break
                }
        }
    }
}
