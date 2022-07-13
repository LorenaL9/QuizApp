import UIKit
import SnapKit

protocol CustomTextFieldDelegate: AnyObject {

    func textFieldDidChange(textField: UIView, text: String?)

}

class LoginInputView: UIView {

    weak var textDelegate: CustomTextFieldDelegate?

    private var textInput: UITextField!
    private var placeholder: String
    private var showPasswordButton: UIButton!
    private(set) var customTextFieldType: CustomTextFieldType!

    init(placeholder: String, customTextFieldType: CustomTextFieldType) {
        self.placeholder = placeholder
        self.customTextFieldType = customTextFieldType
        super.init(frame: .zero)
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func toggleSecureEntry() {
        textInput.isSecureTextEntry = !textInput.isSecureTextEntry

        let image = textInput.isSecureTextEntry
            ? UIImage(systemName: "eye.fill")
            : UIImage(systemName: "eye.slash.fill")
        showPasswordButton.setImage(image, for: .normal)
    }

}

extension LoginInputView: ConstructViewsProtocol {

    func createViews() {
        textInput = UITextField()
        addSubview(textInput)
        textInput.delegate = self

        showPasswordButton = UIButton()
        showPasswordButton.addTarget(self, action: #selector(toggleSecureEntry), for: .touchUpInside)
        addSubview(showPasswordButton)
    }

    func styleViews() {
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        layer.cornerRadius = 20
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        textInput.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)]
        )
        textInput.textColor = .white
        textInput.tintColor = .white
        textInput.autocapitalizationType = .none

        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showPasswordButton.tintColor = .white
        showPasswordButton.isHidden = true

        if customTextFieldType == .password {
            textInput.isSecureTextEntry = true
        }
    }

    func defineLayoutForViews() {
        textInput.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(44)
        }

        showPasswordButton.snp.makeConstraints {
            $0.leading.equalTo(textInput.snp.trailing).inset(6)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(18)
        }
    }

}

extension LoginInputView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if customTextFieldType == .password {
            if customTextFieldType == .password {
                guard let text = textField.text else { return }

                showPasswordButton.isHidden = text.isEmpty
            }
        }

        textDelegate?.textFieldDidChange(textField: self, text: textField.text)
    }

}
