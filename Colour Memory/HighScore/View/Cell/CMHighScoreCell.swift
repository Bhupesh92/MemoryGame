//
//  CMHighScoreCell.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

class CMHighScoreCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func updateCell(user: CMUIProtocol, rank: Int) {
        rankLabel.text = "#\(rank)"
        nameLabel.text = user.getName()
        scoreLabel.text = "Score: \(user.getScore())"
    }
    
}
