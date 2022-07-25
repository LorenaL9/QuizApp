import UIKit
import SnapKit

class UserViewController: UIViewController {

    private var backgroundLayer: CAGradientLayer!
    private var usernameTitleLabel: UILabel!
    private var usernameContentLabel: UILabel!
    private var logoutButton: UIButton!
    private var viewModel: UserViewModel!

    convenience init(viewModel: UserViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @objc func logout() {
        viewModel.logout()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        backgroundLayer = CAGradientLayer()
        view.layer.addSublayer(backgroundLayer)

        usernameTitleLabel = UILabel()
        view.addSubview(usernameTitleLabel)

        usernameContentLabel = UILabel()
        view.addSubview(usernameContentLabel)

        logoutButton = UIButton()
        view.addSubview(logoutButton)
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

        usernameTitleLabel.text = "USERNAME"
        usernameTitleLabel.textColor = .white
        usernameTitleLabel.font = .systemFont(ofSize: 12)

        usernameContentLabel.text = "User1234"
        usernameContentLabel.textColor = .white
        usernameContentLabel.font = .systemFont(ofSize: 20, weight: .bold)

        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 20
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        usernameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        usernameContentLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        logoutButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(44)
        }
    }

}
