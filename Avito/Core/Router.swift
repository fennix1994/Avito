import UIKit

protocol RouterProtocol {
    func start()
    func showDetails(with data: Employee)
}

final class Router: RouterProtocol {
    
    private let window: UIWindow
    private let assembly: Builder
    private let splitViewController: UISplitViewController!
    
    // MARK: - Init
    
    init(
        window: UIWindow,
        assembly: Builder
    ) {
        self.window = window
        self.assembly = assembly
        splitViewController = assembly.buildSplitViewController()
    }
    
    // MARK: - Public methods
    
    func start() {
        let mainViewController = assembly.buildMainModule()
        mainViewController.presenter.onDidCellSelected = { [unowned self] data in
            showDetails(with: data)
        }
        let mainNavigationController = UINavigationController(
            rootViewController: mainViewController
        )
        let emptyViewController = assembly.buildEmptyViewController()
        splitViewController.delegate = self
        splitViewController.viewControllers = [
            mainNavigationController,
            emptyViewController
        ]
        window.rootViewController = splitViewController
    }
    
    func showDetails(with data: Employee) {
        let viewCotroller = assembly.buildDetailModule()
        viewCotroller.presenter.data = data
        splitViewController.showDetailViewController(
            viewCotroller,
            sender: self
        )
    }
}

// MARK: - UISplitViewControllerDelegate

extension Router: UISplitViewControllerDelegate {
    func splitViewController(
      _ splitViewController: UISplitViewController,
      collapseSecondary secondaryViewController: UIViewController,
      onto primaryViewController: UIViewController
    ) -> Bool {
      true
    }
}
