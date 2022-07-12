import UIKit
import Combine
import SnapKit

class LoginViewController: UIViewController {

    private var backgroundLayer: CAGradientLayer!
    private var titleLabel: UILabel!
    private var emailInput: LoginInputView!
    private var passwordInput: LoginInputView!
    private var loginButton: UIButton!
    private var errorLabel: UILabel!
    private var emailPasswordButtonStackView: UIStackView!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var viewModel: LoginViewModel!
    private var disposables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        buildViews()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel
            .$isButtonEnabled
            .sink { [weak self] isButtonEnabled in
                guard let self = self else { return }

                self.loginButton.layer.backgroundColor = isButtonEnabled
                    ? UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                    : UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor
                self.loginButton.isEnabled = isButtonEnabled ? true : false
            }
            .store(in: &disposables)

        viewModel
            .$errorMessage
            .sink { [weak self] errorMessage in
                guard let self = self else { return }

                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = errorMessage == "" ? true : false
            }
            .store(in: &disposables)
    }

    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @objc func tryToLogin() {
        viewModel.validateLogin()
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        backgroundLayer = CAGradientLayer()
        view.layer.addSublayer(backgroundLayer)

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)

        emailPasswordButtonStackView = UIStackView()
        contentView.addSubview(emailPasswordButtonStackView)

        emailInput = LoginInputView(placeholder: "Email", customTextFieldType: .email)
        emailPasswordButtonStackView.addArrangedSubview(emailInput)

        passwordInput = LoginInputView(placeholder: "Password", customTextFieldType: .password)
        emailPasswordButtonStackView.addArrangedSubview(passwordInput)

        errorLabel = UILabel()
        emailPasswordButtonStackView.addArrangedSubview(errorLabel)

        loginButton = UIButton()
        emailPasswordButtonStackView.addArrangedSubview(loginButton)
    }

    func styleViews() {
        backgroundLayer.colors = [
          UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
          UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]
        backgroundLayer.locations = [0, 1]
        backgroundLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        backgroundLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        backgroundLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: -1.95, b: 1.41, c: -1.41, d: -0.41, tx: 2.02, ty: -0.01))
        backgroundLayer.bounds = view.bounds.insetBy(
            dx: -0.5 * view.bounds.size.width,
            dy: -0.5 * view.bounds.size.height)
        backgroundLayer.position = view.center

        titleLabel.text = "PopQuiz"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white

        emailInput.textDelegate = self

        passwordInput.textDelegate = self

        errorLabel.textColor = .red

        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor
        loginButton.layer.cornerRadius = 20
        loginButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.addTarget(self, action: #selector(tryToLogin), for: .touchUpInside)
        loginButton.isEnabled = false

        emailPasswordButtonStackView.axis = .vertical
        emailPasswordButtonStackView.spacing = 18
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(80)
        }

        emailPasswordButtonStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(144)
            $0.leading.equalToSuperview().inset(32)
            $0.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview()
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }

}

extension LoginViewController: CustomTextFieldDelegate {

    func saveInputAndEnableLogin(loginInputView: LoginInputView, text: String) {
        if loginInputView == emailInput {
            viewModel.emailChanged(newEmail: text)
        } else {
            viewModel.passwordChanged(newPassword: text)
        }
        errorLabel.isHidden = true
    }

}
