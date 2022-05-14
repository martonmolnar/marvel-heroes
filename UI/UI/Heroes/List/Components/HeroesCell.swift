//
//  HeroesCell.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import UIKit

class HeroesCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HeroesCell: UIDataBinder {
    struct Data {
        let image: UIImage
        let title: String
    }

    func bind(data: Data) {
        heroImageView.image = data.image
        heroTitleLabel.text = data.title
    }
}
