//
//  SearchFieldComponent.swift
//  UI
//
//  Created by Molnar Marton on 2022. 05. 18..
//

import UIKit
import Common
import RxCocoa
import RxSwift

final class SearchFieldComponent: UIView {
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!

    // MARK: - Properties
    private let searchFieldDidBeginEditing = PublishRelay<String?>()
    private let searchFieldDidEndEditing = PublishRelay<String?>()
    private let searchFieldDidChange = PublishRelay<String?>()
    private let bag = DisposeBag()

    // MARK: - Setters
    override public var accessibilityIdentifier: String? {
        didSet {
            setAccessibilityIds()
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setAccessibilityIds()
    }
}

// MARK: - EventProvider
extension SearchFieldComponent: EventProvider {
    struct Events {
        let searchFieldDidBeginEditing: ControlEvent<String?>
        let searchFieldDidEndEditing: ControlEvent<String?>
        let searchFieldDidChange: ControlEvent<String?>
    }

    var events: Events {
        return Events(
            searchFieldDidBeginEditing: ControlEvent<String?>(events: searchFieldDidBeginEditing),
            searchFieldDidEndEditing: ControlEvent<String?>(events: searchFieldDidEndEditing),
            searchFieldDidChange: ControlEvent<String?>(events: searchFieldDidChange)
        )
    }
}

// MARK: - Public methods
extension SearchFieldComponent {
    func setText(_ text: String) {
        textField.text = text
    }
}

// MARK: - Private methods
private extension SearchFieldComponent {
    func setup() {
        backgroundColor = .clear
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setupTextField()
    }

    func setupTextField() {
        textField.delegate = self
        textField.autocorrectionType = .no
    }
}

// MARK: - UITextFieldDelegate
extension SearchFieldComponent: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
        }
        searchFieldDidEndEditing.accept(textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Accessibility
private extension SearchFieldComponent {
    enum AccessibilityId {
        static let textField = "searchField"
    }

    func setAccessibilityIds() {
        guard let id = self.accessibilityIdentifier else { return }
        textField?.accessibilityIdentifier =
            AccessibilityIdGenerator.idForTextField(with: "\(id)_\(AccessibilityId.textField)")
    }
}

// MARK: - Constants
private extension SearchFieldComponent {
    enum Constants {
        static let buttonSize: CGFloat = 25.0
        static let leftContentOffset: CGFloat = 24.0
    }
}

