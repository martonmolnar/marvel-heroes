//
//  SendMoneyEmptyAccountComponent.swift
//  UI
//
//  Created by Ondresik Tamas on 2019. 09. 09..
//  Copyright © 2019. Supercharge. All rights reserved.
//

import OTPUI
import Common
import RxSwift
import RxCocoa

final class NoResultComponent: OTPComponent {
    // MARK: - Components
    @IBOutlet private weak var container: OTPStackView!
    @IBOutlet private weak var title: OTPLabel!
    @IBOutlet private weak var hint: OTPLabel!
    @IBOutlet private weak var imageView: OTPImageView!
    @IBOutlet private weak var topPadding: NSLayoutConstraint!
    private let button = TertiaryButtonComponent.instantiateFromNib()

    // MARK: - Properties
    private let bag = DisposeBag()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        addComponents()
        clearContent()
        setupUI()
        setAccessibilityIds()
    }
}

// MARK: - Setup
private extension NoResultComponent {
    func addComponents() {
        container.addComponent(button)
    }

    func setupUI() {
        title.font = Constants.titleFont
        title.textColor = Constants.titleColor
        hint.font = Constants.hintFont
        hint.textColor = Constants.hintColor
    }

    func clearContent() {
        title.text = nil
        hint.text = nil
        imageView.image = nil
        button.isHidden = true
    }
}

// MARK: - Data binding
extension NoResultComponent: UIDataBinder {
    struct Data {
        let title: Driver<String>
        let image: Driver<ImageAsset.Image>
        let hint: Driver<String>
        let isHidden: Driver<Bool>
        let buttonTitle: String
        let isButtonHidden: Driver<Bool>
        let topPadding: CGFloat

        init(title: Driver<String>,
             image: Driver<ImageAsset.Image>,
             hint: Driver<String> = .just(""),
             isHidden: Driver<Bool> = .just(false),
             buttonTitle: String = "",
             isButtonHidden: Driver<Bool> = .just(true),
             topPadding: CGFloat = Constants.defaultTopPadding) {
            self.title = title
            self.image = image
            self.hint = hint
            self.isHidden = isHidden
            self.buttonTitle = buttonTitle
            self.isButtonHidden = isButtonHidden
            self.topPadding = topPadding
        }
    }

    func bind(data: Data) {
        data.title.drive(title.rx.text).disposed(by: bag)
        data.hint.drive(hint.rx.text).disposed(by: bag)
        data.image.drive(imageView.rx.image).disposed(by: bag)
        topPadding.constant = data.topPadding
        let actionButtonData = TertiaryButtonComponent.Data(buttonLabel: data.buttonTitle,
                                                            isHidden: data.isButtonHidden,
                                                            backgroundColor: ColorName.Background.clear.color,
                                                            image: .just(Constants.buttonIcon))
        button.bind(data: actionButtonData)
        data.isHidden.drive(rx.isHidden).disposed(by: bag)
    }
}

// MARK: - Event providing
extension NoResultComponent: EventProvider {
    struct Events {
        let buttonTap: ControlEvent<Void>
    }

    var events: Events {
        return Events(buttonTap: .init(events: button.events.tapped))
    }
}

// MARK: - Constants
private extension NoResultComponent {
    enum Constants {
        static let buttonIcon = Asset.Common.arrowRight.image.resize(to: CGSize(width: 14.0, height: 14.0))
        static let fallbackFont = UIFont.systemFont(ofSize: 17)
        static let titleFont = FontFamily.OpenSans.bold.font(size: 17) ?? fallbackFont
        static let hintFont = FontFamily.OpenSans.regular.font(size: 15) ?? fallbackFont
        static let titleColor = ColorName.Text.primary.color
        static let hintColor = ColorName.Text.secondary.color
        static let defaultTopPadding: CGFloat = 0.0
    }
}

// MARK: - Accessibility
private extension NoResultComponent {
    enum AccessibilityId {
        static let image = "no_result_image"
        static let title = "no_result_title"
        static let description = "no_result_description"
    }

    func setAccessibilityIds() {
        imageView.accessibilityIdentifier = AccessibilityId.image
        imageView.isAccessibilityElement = true
        title.accessibilityIdentifier = AccessibilityId.title
        hint.accessibilityIdentifier = AccessibilityId.description
    }
}
