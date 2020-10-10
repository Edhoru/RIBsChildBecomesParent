//
//  RootInteractor.swift
//  Roomi
//
//  Created by Alberto Huerdo on 10/4/20.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func route(to product: UIImage)
    func routeOutChild()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable> {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}


//MARK: RIBs
extension RootInteractor: RootInteractable {
    
    func closeProduct() {
        router?.routeOutChild()
    }
    
}

extension RootInteractor: RootPresentableListener {
    
    func select(product: UIImage) {
        router?.route(to: product)
    }
    
}
