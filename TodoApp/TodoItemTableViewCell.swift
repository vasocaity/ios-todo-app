//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Varaphon Maensiri on 22/7/2561 BE.
//  Copyright © 2561 Varaphon Maensiri. All rights reserved.
//

import UIKit

protocol TodoItemViewCellDelegate:class {
    func todoItemTableViewCellCheckboxButtonDidTap(cell: TodoItemTableViewCell)
}

class TodoItemTableViewCell: UITableViewCell {

    weak var delegate:TodoItemViewCellDelegate?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    @IBAction func checkboxButtonDidTap () {
        delegate?.todoItemTableViewCellCheckboxButtonDidTap(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
