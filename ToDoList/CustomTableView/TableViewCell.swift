//
//  TableViewCell.swift
//  ToDoList
//
//  Created by 橋元雄太郎 on 2022/02/09.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
