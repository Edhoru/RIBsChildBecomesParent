//
//  SellerDetailInteractor.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs
import RxSwift

protocol SellerDetailRouting: ViewableRouting {
    func route(to product: UIImage)
}

protocol SellerDetailPresentable: Presentable {
    var listener: SellerDetailPresentableListener? { get set }
    
    func display(seller: UIImage)
}

protocol SellerDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SellerDetailInteractor: PresentableInteractor<SellerDetailPresentable> {

    //MARK: RIBs
    weak var router: SellerDetailRouting?
    weak var listener: SellerDetailListener?
    
    //MARK: Properties
    let seller: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SellerDetailPresentable,
         seller: UIImage) {
        self.seller = seller
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.display(seller: seller)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}


//MARK: RIBs

extension SellerDetailInteractor: SellerDetailInteractable {
    
}


extension SellerDetailInteractor: SellerDetailPresentableListener {
    
    func select(product: UIImage) {
        router?.route(to: product)
    }
    
}
