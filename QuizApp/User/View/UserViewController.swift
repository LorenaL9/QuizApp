import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
    }

    func styleViews() {
        view.backgroundColor = .blue
    }

    func defineLayoutForViews() {
    }

}