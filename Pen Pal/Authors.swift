//
//  Authors.swift
//  Pen Pal
//
//  Created by min joo on 11/21/22.
//

import UIKit

class Authors: NSObject {
    var name: String
    var id: Int
    var quotes: Array<Quote>?
    
    init(name: String, id: Int){
        self.name = name
        self.id = id
    }
    
    
    func sortQuotesAuthor(array:Array<Quote>)  {
        
        var authorLibrary = [Quote]()
        
        for a in array {
            if (a.name == name) {
                authorLibrary.append(a)
            }
        }
        quotes = authorLibrary
    }
    
}

//global variables of Authors
let natsume = Authors(name: "Natsume Soseki", id: 1)

let hesse = Authors(name: "Hermann Hesse", id: 2)

let turgenev = Authors(name: "Ivan Turgenev", id: 3)

