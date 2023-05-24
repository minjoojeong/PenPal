//
//  LibraryViewController.swift
//  Pen Pal
//
//  Created by min joo on 11/14/22.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingViewControllerDelegate {
    
    
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var authorName: UILabel!
    @IBOutlet var tableView: UITableView!
    var searchResults:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = SettingViewController()
        controller.delegate = self
        
        authorName.text = String(currentAssistant.name)
        
        currentAssistant.sortQuotesAuthor(array: quoteArray)
        
        let nib = UINib(nibName:"LibraryCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LibraryCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //uses delegate to make sure the assistant was changed
    func changeAssistant(myAssistant: Authors) {
        currentAssistant = myAssistant
    }
    
    @IBAction func toSetting(_ sender: UIButton) {
       guard let secondView = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
           fatalError("View Controller not found")}
    secondView.delegate = self //Protocol conformation here
        secondView.modalPresentationStyle = .fullScreen
        secondView.modalTransitionStyle = .flipHorizontal
        
            self.present(secondView, animated: true)
    }
    
    //LibraryViewController
    //formats URL
    func googleURL(searchQuote: Quote) -> URL {
        let searchWork = searchQuote.work
        let searchAuthor = searchQuote.name
        let searchTranslator = searchQuote.translator
        
        let encodedWork = "intitle:" + searchWork.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let encodedAuthor = "inauthor:" + searchAuthor.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        var encodedTLer = ""
        
        if (searchTranslator == "N/A") {
            encodedTLer = ""
            }
        
        else {encodedTLer = searchTranslator.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        
        let encodeLimit = "&maxResults=1".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlSearch = String("https://www.googleapis.com/books/v1/volumes?q=\(encodedWork)+\(encodedAuthor)+\(encodedTLer)\(encodeLimit)")
        
        let url = URL(string: urlSearch)
        return url!
    }

    
    //MARK: table
    //calls BookViewController (which does API call)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var myData:Array<Quote> = currentAssistant.quotes!
         
        
        let url = googleURL(searchQuote:myData[indexPath.row])
        print(googleURL(searchQuote:myData[indexPath.row]))
        
        let selectedQuote = myData[indexPath.row]
            
        
        if let vc = storyboard?.instantiateViewController(identifier: "BooksViewController") as? BooksViewController {
            vc.quotes = selectedQuote
            vc.apiURL = url
            vc.modalPresentationStyle = .popover
            vc.preferredContentSize = CGSize(width: 200, height: 200)
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var myData:Array<Quote> = currentAssistant.quotes!
         
        return myData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myData:Array<Quote> = currentAssistant.quotes!
         
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryCell
        
        //print(myData[indexPath.row].text)
        cell.quoteLabel.text = myData[indexPath.row].text
        
        return cell
 
    } //end table
}


