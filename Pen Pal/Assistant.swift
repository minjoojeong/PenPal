//
//  Assistant.swift
//  Pen Pal
//
//  Created by min joo on 11/28/22.
//

import SwiftUI
import UIKit
import Foundation
import Combine

//singleton class of current assistant
//to be saved into userdefault

class Assistant: ObservableObject {
    @Published var assistant: Authors //default is natsume
    init(assistant: Authors){
        self.assistant = assistant
    }
    
}

var currentAssistant:Authors = natsume
