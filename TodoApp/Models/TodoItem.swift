//
//  TodoItem.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import Foundation


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
