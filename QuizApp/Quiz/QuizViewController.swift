import UIKit

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
    }

    func styleViews() {
        view.backgroundColor = .white
    }

    func defineLayoutForViews() {
    }

}
