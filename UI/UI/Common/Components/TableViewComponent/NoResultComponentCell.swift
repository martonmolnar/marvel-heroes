//
//  NoResultComponentCell.swift
//  UI
//
//  Created by Madarász Krisztián on 2021. 04. 27..
//  Copyright © 2021. Supercharge. All rights reserved.
//

import OTPUI
import UIKit
import RxCocoa
import RxSwift

final class NoResultComponentCell: UITableViewCell {
    // MARK: - Properties
    private(set) var bag = DisposeBag()

    // MARK: - Components
    private let noResultComponent = NoResultComponent.instantiateFromNib()

    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
}

// MARK: - Data binding
extension NoResultComponentCell: UIDataBinder {
    struct Data {
        let title: Driver<String>
        let image: Driver<ImageAsset.Image>
        let hint: Driver<String>
        let buttonTitle: String
        let isButtonHidden: Driver<Bool>

        init(title: Driver<String>,
             image: Driver<ImageAsset.Image>,
             hint: Driver<String> = .just(""),
             buttonTitle: String = "",
             isButtonHidden: Driver<Bool> = .just(true)) {
            self.title = title
            self.image = image
            self.hint = hint
            self.buttonTitle = buttonTitle
            self.isButtonHidden = isButtonHidden
        }
    }

    func bind(data: Data) {
        let componentData = transformData(data)
        noResultComponent.bind(data: componentData)
    }
}

// MARK: - CellEventProvider
extension NoResultComponentCell: CellEventProvider {
    var events: NoResultComponent.Events {
        return noResultComponent.events
    }
}

// MARK: - Private
private extension NoResultComponentCell {
    func setupCell() {
        noResultComponent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noResultComponent)
        noResultComponent.anchorToSuperview()
    }

    func transformData(_ data: Data) -> NoResultComponent.Data {
        return NoResultComponent.Data(
            title: data.title,
            image: data.image,
            hint: data.hint,
            isHidden: .just(false),
            buttonTitle: data.buttonTitle,
            isButtonHidden: data.isButtonHidden
        )
    }
}
