//
//  RootRouter.swift
//  Roomi
//
//  Created by Alberto Huerdo on 10/4/20.
//

import RIBs

protocol RootInteractable: Interactable, HatDetailListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    
    private let hatDetailBuilder: HatDetailBuildable
    private var currentChild: ViewableRouting?
    
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         hatDetailBuilder: HatDetailBuildable) {
        self.hatDetailBuilder = hatDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    private var loggedOut: ViewableRouting?
    
}


//MARK: RIBs

extension RootRouter: RootRouting {
    
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
