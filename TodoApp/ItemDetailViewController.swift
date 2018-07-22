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
    func addItemViewController(controller: ItemDetailViewController, didAdd item: TodoItem)
    func addItemViewController(controller: ItemDetailViewController, didEdit item: TodoItem)
    func addItemViewControllerDidCancel(controller: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {

    weak var delegate: AddItemViewControllerDelegate?
    var todoItem: TodoItem?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    
    @IBAction func doneButtonDidTap() {

        if let title = titleTextField.text, let isDone = isDoneSwitch?.isOn ,!title.isEmpty {
            
            if let item = todoItem {
                item.title = title
                item.isDone = isDone
                delegate?.addItemViewController(controller: self, didEdit: item)
            }else {
                let item = TodoItem(title: title, isDone: isDone)
                delegate?.addItemViewController(controller: self, didAdd: item);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = todoItem {
            titleTextField?.text = item.title
            isDoneSwitch?.isOn = item.isDone
            
            title = "Edit item"
        }else {
            title = "Add new item"
        }
    }
    
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    //outlet คือ วิวที่อ้างอิงถึง
    // action คือให้มันทำไร
    // ref couting
    // ! คือ มีเสมอ
    // ? มี ไม่มี ก็ได้ดดด

}
