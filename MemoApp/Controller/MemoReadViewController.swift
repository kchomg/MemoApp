//
//  MemoReadViewController.swift
//  MemoApp
//
//  Created by Seok Eun Hong on 2021/09/26.
//

import UIKit

// 상세화면
class MemoReadViewController: UIViewController {
    var param: MemoData?
    
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "MM월 dd일 eeee HH:mm분에 작성"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
        
        print(param?.contents!)
    }
}
