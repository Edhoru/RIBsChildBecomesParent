//
//  PumpkinDetailInteractor.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs
import RxSwift

protocol PumpkinDetailRouting: ViewableRouting {
    func route(to hat: UIImage)
    func routeOutChild()
}

protocol PumpkinDetailPresentable: Presentable {
    var listener: PumpkinDetailPresentableListener? { get set }
    
    func display(pumpkin: UIImage)
}

protocol PumpkinDetailListener: class {
    func closePumpkin()
}

final class PumpkinDetailInteractor: PresentableInteractor<PumpkinDetailPresentable> {

    //MARK: RIBs
    weak var router: PumpkinDetailRouting?
    weak var listener: PumpkinDetailListener?
    
    //MARK: Properties
    let pumpkin: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: PumpkinDetailPresentable,
         pumpkin: UIImage) {
        self.pumpkin = pumpkin
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.display(pumpkin: pumpkin)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}


//MARK: RIBs

extension PumpkinDetailInteractor: PumpkinDetailInteractable {
    
    func closeHat() {
        router?.routeOutChild()
    }
}


extension PumpkinDetailInteractor: PumpkinDetailPresentableListener {
    
    func close() {
        listener?.closePumpkin()
    }
    
    func select(hat: UIImage) {
        router?.route(to: hat)
    }
    
}
