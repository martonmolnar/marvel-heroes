//
//  HeroesCell.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import Common
import RxCocoa
import RxSwift

class HeroesCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroTitleLabel: UILabel!

    // MARK: - Properties
    private(set) var bag = DisposeBag()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearContent()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearContent()
        bag = DisposeBag()
    }
}

// MARK: - Data binding
extension HeroesCell: UIDataBinder {
    struct Data {
        let image: Driver<UIImage?>
        let title: String
    }

    func bind(data: Data) {
        heroTitleLabel.text = data.title
        data.image
            .drive(heroImageView.rx.image)
            .disposed(by: bag)
    }
}

// MARK: - Event providing
extension HeroesCell: CellEventProvider {
    struct Events {
    }

    var events: Events {
        return Events()
    }
}

// MARK: - Private
private extension HeroesCell {
    func setup() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        heroImageView.backgroundColor = .clear
    }

    func clearContent() {
        heroImageView.image = nil
        heroTitleLabel.text = nil
    }
}
