//
//  HeroDetailsComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import UIKit
import RxSwift
import RxCocoa

class HeroDetailsComponent: UIView {

    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var detailsStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    private var bag = DisposeBag()

    // MARK: - UIView overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension HeroDetailsComponent: UIDataBinder {
    struct Data {
        let image: Driver<UIImage?>
        let name: Driver<String>
        let description: Driver<String>
    }

    func bind(data: Data) {
        data.image
            .drive(heroImageView.rx.image)
            .disposed(by: bag)

        data.name
            .drive(nameLabel.rx.text)
            .disposed(by: bag)

        data.description
            .map({ (description: String) -> String in
                return description.isEmpty ? "There is no description to this hero" : description
            })
            .drive(descriptionLabel.rx.text)
            .disposed(by: bag)
    }
}
