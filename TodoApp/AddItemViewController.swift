//
//  AddItemViewController.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    //outlet คือ วิวที่อ้างอิงถึง
    // action คือให้มันทำไร
    
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

}
