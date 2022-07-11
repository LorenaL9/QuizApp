import UIKit
import SnapKit

protocol ActiveLoginButtonDelegate: AnyObject {

    func activate(inputFieldView: InputFieldView, text: String)

}

class InputFieldView: UIView {

    weak var textDelegate: ActiveLoginButtonDelegate?

    private var textInput: UITextField!
    private var placeholder: String
    private var showPasswordButton: UIButton!

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        textInput = UITextField()
        addSubview(textInput)
        textInput.delegate = self

        showPasswordButton = UIButton()
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        addSubview(showPasswordButton)
    }

    private func styleViews() {
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

        if placeholder == "Password" {
            textInput.isSecureTextEntry = true
        }
    }

    private func defineLayoutForViews() {
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

    @objc func showPassword() {
        if textInput.isSecureTextEntry {
            textInput.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            textInput.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }

}

extension InputFieldView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if placeholder == "Password" {
            if textInput.text == "" {
                showPasswordButton.isHidden = true
            } else {
                showPasswordButton.isHidden = false
            }
        }

        textDelegate?.activate(inputFieldView: self, text: textInput.text ?? "")
    }

}
