//
//  PumpkinDetailRouter.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol PumpkinDetailInteractable: Interactable, HatDetailListener {
    var router: PumpkinDetailRouting? { get set }
    var listener: PumpkinDetailListener? { get set }
}

protocol PumpkinDetailViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class PumpkinDetailRouter: ViewableRouter<PumpkinDetailInteractable, PumpkinDetailViewControllable> {
    
    private let hatDetailBuilder: HatDetailBuildable
    private var currentChild: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: PumpkinDetailInteractable,
         viewController: PumpkinDetailViewControllable,
         hatDetailBuilder: HatDetailBuildable) {
        self.hatDetailBuilder = hatDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


//MARK: RIBs

extension PumpkinDetailRouter: PumpkinDetailRouting {
    
    func route(to hat: UIImage) {
        let hatDetail = hatDetailBuilder.build(withListener: interactor,
                                                       hat: hat)
        currentChild = hatDetail
        attachChild(hatDetail)
        
        viewController.present(viewController: hatDetail.viewControllable)
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
