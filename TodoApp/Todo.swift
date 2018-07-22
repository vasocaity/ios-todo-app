//
//  Todo.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import Foundation

class Todo {
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
}

class TodoItem {
    var title: String
    var isDone: Bool
    
    init(title:String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
    
    func toggleIsDone () {
        isDone = !isDone
    }
}
