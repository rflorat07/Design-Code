//
//  QuestionCollectionViewCell.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 28/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

protocol QuestionCellDelegate : class {
    func questionCell(_ cell : QuestionCollectionViewCell, didTapAnswerButton button : UIButton, forQuestion question : Dictionary<String,Any>)
}

class QuestionCollectionViewCell: UICollectionViewCell {
    
    weak var delegate : QuestionCellDelegate?
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    var question : Dictionary<String,Any>!
    
    @IBAction func didTapAnswerButton(_ sender: UIButton) {
        
        delegate?.questionCell(self, didTapAnswerButton: sender, forQuestion: question)
        
        sender.setImage(UIImage(named: "Exercises-Check"), for: .normal)
    }
    
}
