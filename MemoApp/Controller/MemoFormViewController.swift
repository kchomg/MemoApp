//
//  MemoFormViewController.swift
//  MemoApp
//
//  Created by Seok Eun Hong on 2021/09/26.
//

import UIKit

class MemoFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    lazy var dao = MemoDAO()
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preivew: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preivew.image
        data.regdate = Date()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.memolist.append(data)
        
        // 코어 데이터에 메모 데이터를 추가.
        self.dao.insert(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
        
//        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (_) in
//            picker.sourceType = .camera
//            self.present(picker, animated: false, completion: nil)
//        }))
        
        alert.addAction(UIAlertAction(title: "사진 라이브러리", style: .default, handler: { (_) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: false, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "저장 앨범", style: .default, handler: { (_) in
            picker.sourceType = .savedPhotosAlbum
            self.present(picker, animated: false, completion: nil)
        }))
        
        self.present(alert, animated: false, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preivew.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        self.contents.delegate = self
        
        let bgImg = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImg)
        
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        // 줄 간격 설정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle: style])
        self.contents.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        self.navigationItem.title = self.subject
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        let time = TimeInterval(0.3)
        UIView.animate(withDuration: time) {
            bar?.alpha = ( bar?.alpha == 0 ? 1 : 0)
        }
    }
}
