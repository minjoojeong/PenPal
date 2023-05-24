//
//  WikiController.swift
//  Pen Pal
// Display wiki info
//  Created by min joo on 12/4/22.
//

import UIKit
import SwiftUI

class WikiController: UIViewController {
    
    @IBOutlet var authorName: UILabel!
    @IBOutlet var textBox: UILabel!
    
    @IBOutlet var wikiImage: UIImageView!
    
    var quotes:Quote?
    var apiURL:URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.backgroundColor = .clear
        
        authorName.text = String(currentAssistant.name)
        
        
        apiURL = wikiMedia()
        apiCall(url:apiURL!)
        
        
    }
    
    func wikiMedia() -> URL {
        
        var authorName = ""
        if (currentAssistant != natsume) {
            authorName = currentAssistant.name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        else if (currentAssistant == natsume) {
            authorName = "Natsume Sōseki".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            }
            
        let urlSearch = String("https://en.wikipedia.org/w/api.php?action=query&exlimit=1&explaintext=1&exsentences=3&formatversion=2&prop=extracts&titles=\(authorName)&format=json")
        
       let wikiURL = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts%7Cpageimages&titles=\(authorName)&formatversion=2&exsentences=3&exlimit=1&explaintext=1&piprop=thumbnail%7Cname&pithumbsize=300"
        
        let url = URL(string: wikiURL)
        
        return (url)!
    }
    
    
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
                print(jsonString)
                var resultText = ""
                var WIKIurl: URL?
                do {
                   let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                   let result = try decoder.decode(WikiImage.self, from: data!)
                    
                    let imgURLString = (result.query.pages?[0].thumbnail?.source!)!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    WIKIurl = NSURL(string: imgURLString)! as URL
                    //let imgLink = URL(string:imgURLString)
                    
                    //print(result.query.pages?[0].extract!)
                    resultText = (result.query.pages?[0].extract!) ?? ""
                    
                    
                    //var apiResult:APIResults = result.items!
                   // print("\(apiResult)")
                } catch {
                  print(error)
                }
                
                
               // print("THIS SHOULD BE UPDATED \(test.json)")
                DispatchQueue.main.async {
                    self.textBox.text =  "(From Wikipedia.org)  \(resultText)"
                    //var wikiIMG = imgLink
                    if let imageData: NSData = NSData(contentsOf: WIKIurl!) {
                        self.wikiImage.image = UIImage(data: imageData as Data)
                    }
                    //self.wikiImage.image
                }
                
            }
            else {
                print("nice!\(response!)")
            }
        }
        dataTask.resume()
    }
    
    func apiDisplay(searchResult:WikiImage)-> String {
        
        var text = ""
        
        text = (searchResult.query.pages?[0].extract)!
        
        return text
    }
    
    
    
}
