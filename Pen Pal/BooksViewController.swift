//
//  BooksViewController.swift
//  Pen Pal
//
//  Created by min joo on 12/4/22.
//

import UIKit
import SwiftUI

class BooksViewController: UIViewController {
    
    @IBOutlet var workName: UILabel!
    @IBOutlet var textBox: UILabel!
    
    var quotes:Quote?
    var apiURL:URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.backgroundColor = .clear
        print(quotes!.work)
        
        workName.text = String(quotes!.work)
        
        apiCall(url:apiURL!)
        
        
    }
    
    //API Call for Google Books
    func apiCall(url: URL) {
        //session
        let session = URLSession.shared
        //
        let dataTask = session.dataTask(with: url) {data, response, error in
            if let error = error {
                print("FAIL! \(error.localizedDescription)")
            }
            else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Data retrieved: \(data!)")
                let jsonString = String(data: data!, encoding: .utf8)
                //test.json = "\(jsonString)"
                
                var resultText = ""
                
                do {
                   let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                   let result = try decoder.decode(SearchResult.self, from: data!)
                    
                    resultText = self.apiDisplay(searchResult: result)
                    
                    
                    //var apiResult:APIResults = result.items!
                   // print("\(apiResult)")
                } catch {
                  print(error)
                }
                
                
               // print("THIS SHOULD BE UPDATED \(test.json)")
                DispatchQueue.main.async {
                    self.textBox.text =  resultText
                }
                
            }
            else {
                print("nice!\(response!)")
            }
        }
        dataTask.resume()
    }
    
    //presenting my parsed data nicely
    func apiDisplay(searchResult:SearchResult)-> String {
        let apiResult = searchResult.items[0]
        
        var text = ""
        
        let link = "Link: \( (apiResult.selfLink ?? "API Link Not Available")! )\n"
        print(link)
        //text += link
        
        let title = "Title: \( (apiResult.volumeInfo?.title ?? "Title Not Available")! )\n"
        text += title
        
        let subtitle = "Subtitle: \( (apiResult.volumeInfo?.subtitle ?? "")! )\n"
        text += subtitle
        
        let authors = (apiResult.volumeInfo?.authors) ?? []
        var authorList = "Authors: "
        for author in authors {
            authorList += "\(author);"
        }
        authorList += "\n"
        text += authorList
        
        let publisher = "Publisher: \( (apiResult.volumeInfo?.publisher ?? "Publisher Not Available")! )\n"
        text += publisher
        
        let publishedDate = "Published Date: \( (apiResult.volumeInfo?.publishedDate ?? "Published Date Not Available")! )\n"
        text += publishedDate
        
        let desc = "Description: \( (apiResult.volumeInfo?.description ?? "Description Not Available")! )\n"
        text += desc
        
        return text
    }
    
    
}
