//
//  Todo.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import Foundation

class Todo:Codable {
    private var items = [TodoItem]()
    
    var totalItems: Int {
        return items.count
    }
    
    func add (item: TodoItem) {
        items.insert(item, at: 0)
    }
    
    func remove(at index: Int) {
        items.remove(at: index)
    }
    
    func itemATIndex(at index: Int) -> TodoItem{
        return items[index]
    }
    // ? อาจจะไม่มีก็ได้
    func indexOfItem(of item: TodoItem) -> Int? {
        return items.index { $0 === item }
        
//        return items.index(where: { (todoItem) -> Bool in
//            todoItem === item  // === ref ตัวเดียวกัน == เท่ากันเฉยๆ ไม่ใช่ object เดียวกัน
//        })
    }
    
    func move(from sourceIndex: Int, to desitinationIndex: Int) {
        let item = items.remove(at: sourceIndex)
        items.insert(item, at: desitinationIndex)
    }
}

