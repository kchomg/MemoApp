//
//  MemoData.swift
//  MemoApp
//
//  Created by Seok Eun Hong on 2021/09/26.
//

import UIKit
import CoreData

class MemoData {
    var memoIdx: Int?
    var title: String?
    var contents: String?
    var image: UIImage?
    var regdate: Date?
    
    var objectID: NSManagedObjectID?
}
