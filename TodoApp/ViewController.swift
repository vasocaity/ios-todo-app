//
//  ViewController.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate, TodoItemViewCellDelegate, UITableViewDragDelegate, UITableViewDropDelegate{
    
    func todoItemTableViewCellCheckboxButtonDidTap(cell: TodoItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            todo.itemATIndex(at: indexPath.row).toggleIsDone()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func addItemViewController(controller: AddItemViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        if let index = todo.indexOfItem(of: item) {
            tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        if controller.isInEditMode {
            navigationController?.popViewController(animated: true)
        } else {
        controller.dismiss(animated: true, completion: nil)
        }

    }
    
    func addItemViewController(controller: AddItemViewController, didEdit item: TodoItem) {
        if let index = todo.indexOfItem(of: item) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        saveTodo ()
        navigationController?.popViewController(animated: true)
        //controller.dismiss(animated: true, completion: nil)
    }
    
    
    var todo = Todo()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }
    /*
     DRAGE
     */
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.localDragSession != nil
    }
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = todo.itemATIndex(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
            as! TodoItemTableViewCell
        cell.delegate = self
        cell.titleLabel.text =  item.title
        cell.checkboxButton.setImage(UIImage(named: item.isDone ? "check": "uncheck" ), for: .normal)
        saveTodo ()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openEditPage", sender: todo.itemATIndex(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        saveTodo()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todo.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        saveTodo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.dropDelegate = self
        loadTodo()
    }
    func loadTodo() {
        do {
            let fileManager = FileManager.default
            var destinationURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            destinationURL.appendPathComponent("todo")
            destinationURL.appendPathExtension("plist")
            
            print(destinationURL.path)
            
            if fileManager.fileExists(atPath: destinationURL.path) {
                let data = try Data(contentsOf: destinationURL)
                let decoder = PropertyListDecoder()
                todo = try decoder.decode(Todo.self, from: data)
                tableView.reloadData()
            }
        }catch {
            print("cannot open file",error)
        }
        
    }
    
    func saveTodo () {
        do {
            let fileManager = FileManager.default
            var destinationURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            destinationURL.appendPathComponent("todo")
            destinationURL.appendPathExtension("plist")
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let data = try encoder.encode(todo)
            try data.write(to: destinationURL)
            print(destinationURL.path)
        }catch {
            print("cannot open file",error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openAddPage" {
            let navigationController = segue.destination as? UINavigationController
            let controller = navigationController?.topViewController as? AddItemViewController
            controller?.delegate = self
        }else if segue.identifier == "openEditPage" {
            let controller = segue.destination as? AddItemViewController
           // let controller = navigationController?.topViewController as? AddItemViewController
            controller?.delegate = self
            controller?.todoItem = sender as? TodoItem
        }
    }
    
}
