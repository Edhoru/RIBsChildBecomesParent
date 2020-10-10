//
//  RootRouter.swift
//  Roomi
//
//  Created by Alberto Huerdo on 10/4/20.
//

import RIBs

protocol RootInteractable: Interactable, ProductDetailListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    
    private let productDetailBuilder: ProductDetailBuildable
    private var currentChild: ViewableRouting?
    
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         productDetailBuilder: ProductDetailBuildable) {
        self.productDetailBuilder = productDetailBuilder
        
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
    
    func route(to product: UIImage) {
        let productDetail = productDetailBuilder.build(withListener: interactor,
                                                       product: product)
        currentChild = productDetail
        attachChild(productDetail)
        
        viewController.present(viewController: productDetail.viewControllable)
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
