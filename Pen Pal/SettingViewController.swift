//
//  SettingViewController.swift
//  Pen Pal
//
//  Created by min joo on 11/21/22.
//

import UIKit
import Foundation
import Combine

protocol SettingViewControllerDelegate: AnyObject {
    func changeAssistant(myAssistant:Authors)
}

class SettingViewController: UIViewController {
    
    weak var delegate: SettingViewControllerDelegate?
   // var currentAssistant = natsume
    @IBOutlet var changeNatsume: UIButton!
    @IBOutlet var changeHesse: UIButton!
    @IBOutlet var changeTurgenev: UIButton!
    
    
    @IBOutlet var appCredits: UIButton!
    @IBOutlet var appSources: UIButton!
    
    
    var authorList: [String : Authors] = [
        "natsume" : natsume,
        "hesse" : hesse,
        "turgenev": turgenev
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
//do stuff
    }
    
    
    //pass to delegate
    @IBAction func changeAuthor(sender: UIButton) {
        
        if (sender == changeNatsume){
            //currentAssistant = natsume
            self.delegate?.changeAssistant(myAssistant: natsume)
            UserDefaults.standard.set("natsume",forKey: "defaultAssistant")
        }
        
        if (sender == changeHesse){
           // currentAssistant = hesse
            self.delegate?.changeAssistant(myAssistant: hesse)
            UserDefaults.standard.set("hesse",forKey: "defaultAssistant")
        }
        
        if (sender == changeTurgenev){
           // currentAssistant = turgenev
            self.delegate?.changeAssistant(myAssistant: turgenev)
            UserDefaults.standard.set("turgenev",forKey: "defaultAssistant")
        }
        
    }
    
    //popover view to see credits
    @IBAction func seeCredits(sender: UIButton){
        
        if let vc = storyboard?.instantiateViewController(identifier: "CreditViewController") as? CreditViewController {
            vc.modalPresentationStyle = .popover
            vc.optionTitle = sender.currentTitle
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
}
