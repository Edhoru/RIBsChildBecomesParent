//
//  SellerDetailRouter.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol SellerDetailInteractable: Interactable, ProductDetailListener {
    var router: SellerDetailRouting? { get set }
    var listener: SellerDetailListener? { get set }
}

protocol SellerDetailViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class SellerDetailRouter: ViewableRouter<SellerDetailInteractable, SellerDetailViewControllable> {
    
    private let productDetailBuilder: ProductDetailBuildable
    private var currentChild: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SellerDetailInteractable,
         viewController: SellerDetailViewControllable,
         productDetailBuilder: ProductDetailBuildable) {
        self.productDetailBuilder = productDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


//MARK: RIBs

extension SellerDetailRouter: SellerDetailRouting {
    
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
