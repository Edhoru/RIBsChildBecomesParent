//
//  HatRouter.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol HatDetailInteractable: Interactable, PumpkinDetailListener {
    var router: HatDetailRouting? { get set }
    var listener: HatDetailListener? { get set }
}

protocol HatDetailViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class HatDetailRouter: ViewableRouter<HatDetailInteractable, HatDetailViewControllable> {
    
    private let pumpkinDetailBuilder: PumpkinDetailBuildable
    private var currentChild: ViewableRouting?
    
    init(interactor: HatDetailInteractable,
         viewController: HatDetailViewControllable,
         pumpkinDetailBuilder: PumpkinDetailBuildable) {
        self.pumpkinDetailBuilder = pumpkinDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


extension HatDetailRouter: HatDetailRouting {
    
    func route(to pumpkin: UIImage) {
        let pumpkinDetail = pumpkinDetailBuilder.build(withListener: interactor,
                                                       pumpkin: pumpkin)
        currentChild = pumpkinDetail
        attachChild(pumpkinDetail)
        
        viewController.present(viewController: pumpkinDetail.viewControllable)
    }
    
    func routeOutChild() {
        guard let currentChild = self.currentChild else {
            return
        }
        
        detachChild(currentChild)
        viewController.dismiss(viewController: currentChild.viewControllable)
        self.currentChild = nil
    }
    
}
