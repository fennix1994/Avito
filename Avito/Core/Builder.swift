import UIKit

protocol BuilderProtocol {
    func buildSplitViewController() -> UISplitViewController
    func buildMainModule() -> MainViewController
    func buildDetailModule() -> DetailViewController
    func buildEmptyViewController() -> EmptyViewController
}

final class Builder: BuilderProtocol {
    
    let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func buildSplitViewController() -> UISplitViewController {
        let view = UISplitViewController()
        view.preferredDisplayMode = .oneBesideSecondary
        return view
    }
    
    func buildMainModule() -> MainViewController {
        let view = MainViewController()
        let presenter = MainPresenter(
            networkService: networkService
        )
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func buildDetailModule() -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func buildEmptyViewController() -> EmptyViewController {
        EmptyViewController()
    }
}
