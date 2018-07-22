//
//  AddItemViewController.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import UIKit

// spec ของคนที่จะเรียก
protocol AddItemViewControllerDelegate:class {
    // (who call, call ด้วยของอันนี้)
    func addItemViewController(controller: AddItemViewController, didAdd item: TodoItem)
    func addItemViewControllerDidCancel(controller: AddItemViewController)
}

class AddItemViewController: UIViewController {

    weak var delegate: AddItemViewControllerDelegate?
  
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    
    @IBAction func doneButtonDidTap() {
        
        if let title = titleTextField.text, let isDone = isDoneSwitch?.isOn ,!title.isEmpty {
            let item = TodoItem(title: title, isDone: isDone)
            delegate?.addItemViewController(controller: self, didAdd: item);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //outlet คือ วิวที่อ้างอิงถึง
    // action คือให้มันทำไร
    // ref couting
    // ! คือ มีเสมอ
    // ? มี ไม่มี ก็ได้ดดด

}
