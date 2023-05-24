//
//  CreditViewController.swift
//  Pen Pal
//
//  Created by min joo on 12/9/22.
//

import UIKit

class CreditViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var creditChoice: UILabel!
    @IBOutlet var textBox: UILabel!
    var optionTitle:String?
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditChoice.text = optionTitle
        textBox.text = getFileData()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+100)
        // Do any additional setup after loading the view.
    }
    
    
    
    //read file data for my credit and sources 
    func getFileData() -> String {
        var fullText = ""
        var buttonType = ""
        
        if (optionTitle! == "APP CREDITS") {
            buttonType = "Credit"
        }
        
        if (optionTitle! == "Sources") {
            buttonType = "Sources"
        }
        
        let filename = buttonType

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
            for line in lines {
                print(line)
                fullText += line
                fullText += "\n"
            }
            
            return fullText
            
        }
        catch {
            return ""
        }
    }

}
