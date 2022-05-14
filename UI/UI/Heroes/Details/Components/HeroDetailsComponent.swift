//
//  HeroDetailsComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import UIKit

class HeroDetailsComponent: UIView {

    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var detailsStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension HeroDetailsComponent: UIDataBinder {
    struct Data {
        let image: UIImage
        let name: String
        let description: String
    }

    func bind(data: Data) {
        heroImageView.image = data.image
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
}
