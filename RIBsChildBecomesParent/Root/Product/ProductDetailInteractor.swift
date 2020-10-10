//
//  ProductInteractor.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs
import RxSwift

protocol ProductDetailRouting: ViewableRouting {
    func route(to seller: UIImage)
    func routeOutChild()
}

protocol ProductDetailPresentable: Presentable {
    var listener: ProductDetailPresentableListener? { get set }
    
    func display(product: UIImage)
}

protocol ProductDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ProductDetailInteractor: PresentableInteractor<ProductDetailPresentable> {

    //MARK: RIBs
    weak var router: ProductDetailRouting?
    weak var listener: ProductDetailListener?
    
    //MARK: Properties
    let product: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ProductDetailPresentable,
                  product: UIImage) {
        self.product = product
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.display(product: product)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
}


//MARK: RIBs
extension ProductDetailInteractor: ProductDetailInteractable {
    
}

extension ProductDetailInteractor: ProductDetailPresentableListener {
    
    func select(seller: UIImage) {
        router?.route(to: seller)
    }
    
    
}
