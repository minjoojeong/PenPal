//
//  Library.swift
//  Pen Pal
//
//  Created by min joo on 11/28/22.
//

import Foundation
import UIKit
//initializes an Array for each author that is current assistant to display into table view and to pick quotes from
class Library:NSObject {
    
    
    //make a dictionary for lookup
    
    var authorList: [String : Authors] = [
        "natsume" : natsume,
        "hesse" : hesse,
        "turgenev": turgenev
    ]
    
    //puts quotes into array based on csv data
    func getCSVData() -> Array<Quote> {
        
        
        let filename = "quotes" //Author, Name, Quote, Book, Translator, ID

        guard let file = Bundle.main.url(forResource: filename, withExtension: "txt")
                
        else {

            fatalError("Couldn't find \(filename) in main bundle.")
        }
        //use file in bundle
        
        do {
            let contents = try String(contentsOf: file, encoding: String.Encoding.macOSRoman )
            //separate by line
            let lines: [String] = contents.components(separatedBy:"\n")
            //parse by tab
            var library = [[String]]()
            for line in lines {
                library.append(line.components(separatedBy: "\t"))
            }
            
            var quoteList = [Quote]()
            for q in library {
                
                let intID: Int? = Int(q[5])
                
                let newQuote = Quote(author:authorList[q[0]]!,name:q[1],text:q[2],work:q[3],translator:q[4],quoteid:intID ?? 0,obtained:true
                )
                quoteList.append(newQuote)
            }
            
            return quoteList
            
        }
        catch {
            return []
        }
    }
    
    
}

//Access class

let quoteLibrary = Library()
let quoteArray:Array<Quote> = quoteLibrary.getCSVData()

