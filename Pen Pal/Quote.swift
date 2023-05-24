//
//  Quote.swift
//  Pen Pal
//
//  Created by min joo on 11/21/22.
//

import UIKit
import Foundation
//custom class to store CSV read object in
class Quote: NSObject {
    var author: Authors
    var name: String
    var text: String
    var work: String
    var translator: String
    var quoteid: Int
    var obtained: Bool = false
    
    init(author: Authors, name: String, text: String, work: String, translator: String, quoteid: Int, obtained: Bool) {
        self.author = author
        self.name = name
        self.text = text
        self.work = work
        self.translator = translator
        self.quoteid = quoteid
        self.obtained = obtained
    }
}

