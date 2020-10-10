//
//  HatInteractor.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs
import RxSwift

protocol HatDetailRouting: ViewableRouting {
    func route(to pumpkin: UIImage)
    func routeOutChild()
}

protocol HatDetailPresentable: Presentable {
    var listener: HatDetailPresentableListener? { get set }
    
    func display(hat: UIImage)
}

protocol HatDetailListener: class {
    func closeHat()
}

final class HatDetailInteractor: PresentableInteractor<HatDetailPresentable> {

    //MARK: RIBs
    weak var router: HatDetailRouting?
    weak var listener: HatDetailListener?
    
    //MARK: Properties
    let hat: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: HatDetailPresentable,
                  hat: UIImage) {
        self.hat = hat
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.display(hat: hat)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
}


//MARK: RIBs
extension HatDetailInteractor: HatDetailInteractable {
    
    func closePumpkin() {
        router?.routeOutChild()
    }
    
}

extension HatDetailInteractor: HatDetailPresentableListener {
    
    func close() {
        listener?.closeHat()
    }
    
    func select(pumpkin: UIImage) {
        router?.route(to: pumpkin)
    }
    
    
}
