//
//  ViewController.swift
//  Pen Pal
//
//  Created by min joo on 11/14/22.
//

import UIKit
import Foundation

class ViewController: UIViewController, SettingViewControllerDelegate {
    
    
    @IBOutlet var authorImage: UIImageView!
    @IBOutlet weak var authorQuote: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    
    var quoteLists:Array<Quote> = [Quote]()
    
    
    var authorList: [String : Authors] = [
        "natsume" : natsume,
        "hesse" : hesse,
        "turgenev": turgenev
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //user default assistant
        checkAssistant()
        
        authorImage.image = UIImage(named: currentAssistant.name)
        
        currentAssistant.sortQuotesAuthor(array: quoteArray)
        quoteLists = currentAssistant.quotes!
        
        authorButton.titleLabel?.numberOfLines = 5;
        authorButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        //display quotes randomly
        if let random = quoteLists.randomElement()?.text {
            print("The random quote is: \(random).")
            authorButton.setTitle(random, for: .normal)
        }
        
    }
    
    //MARK: Change Assistant using delegate(settingVC)
    func changeAssistant(myAssistant: Authors) {
       currentAssistant = myAssistant
    }
    
    //check userdefaults
    func checkAssistant() {
        let defaultAssistant = UserDefaults.standard.value(forKey: "defaultAssistant") as? String ?? "natsume"
    
        currentAssistant = authorList[defaultAssistant] ?? natsume
    }
    
    //Setting button, instantiate new view that can call custom delegate which switches current assistant
    //all the other buttons are programmed using xcode though
    
    @IBAction func toSetting(_ sender: UIButton) {
       guard let secondView = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
           fatalError("View Controller not found")}
    secondView.delegate = self //Protocol conformation here
        secondView.modalPresentationStyle = .fullScreen
        secondView.modalTransitionStyle = .flipHorizontal
        
            self.present(secondView, animated: true)
    }
    
    //MARK: Quote change
    @IBAction func newQuote(sender: UIButton){
        print("new quote")
        
        if let random = quoteLists.randomElement()?.text {
            print("The random quote is: \(random).")
            sender.setTitle(random, for: .normal)
        }
        //animate image
        
        if (self.authorImage.image == UIImage(named: currentAssistant.name)){
            changeImg()
        }
        else {
            changeBack()
        }
        //animate image
    }
    
    func changeImg() {
        UIView.transition(with: authorImage,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.authorImage.image = UIImage(named: ("Next "+currentAssistant.name)) },
                          completion: nil)
    }
    
    func changeBack() {
        UIView.transition(with: authorImage,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.authorImage.image = UIImage(named: currentAssistant.name) },
                          completion: nil)
    }
    //end quote changes
    
    //MARK: wiki API call
    //i did two API calls instead of core data because core data meant i had to rewrite all my custom classes and make every code conform to that...
    //I should've selected core data from the beginning
    @IBAction func wikiLink(sender: UIButton){
        
        
        if let vc = storyboard?.instantiateViewController(identifier: "WikiController") as? WikiController {
            vc.modalPresentationStyle = .popover
            //vc.preferredContentSize = CGSize(width: 200, height: 200)
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
}


