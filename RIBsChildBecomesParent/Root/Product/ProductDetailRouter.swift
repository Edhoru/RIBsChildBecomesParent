//
//  ProductRouter.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol ProductDetailInteractable: Interactable, SellerDetailListener {
    var router: ProductDetailRouting? { get set }
    var listener: ProductDetailListener? { get set }
}

protocol ProductDetailViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class ProductDetailRouter: ViewableRouter<ProductDetailInteractable, ProductDetailViewControllable> {
    
    private let sellerDetailBuilder: SellerDetailBuildable
    private var currentChild: ViewableRouting?
    
    init(interactor: ProductDetailInteractable,
         viewController: ProductDetailViewControllable,
         sellerDetailBuilder: SellerDetailBuildable) {
        self.sellerDetailBuilder = sellerDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}


extension ProductDetailRouter: ProductDetailRouting {
    
    func route(to seller: UIImage) {
        let sellerDetail = sellerDetailBuilder.build(withListener: interactor,
                                                       seller: seller)
        currentChild = sellerDetail
        attachChild(sellerDetail)
        
        viewController.present(viewController: sellerDetail.viewControllable)
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
