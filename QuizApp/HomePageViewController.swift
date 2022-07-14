import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension HomePageViewController: ConstructViewsProtocol {

    func createViews() {

    }

    func styleViews() {
        view.backgroundColor = .blue
    }

    func defineLayoutForViews() {

    }

}
