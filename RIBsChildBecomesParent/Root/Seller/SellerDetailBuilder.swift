//
//  SellerDetailBuilder.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol SellerDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SellerDetailComponent: Component<SellerDetailDependency>, ProductDetailDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SellerDetailBuildable: Buildable {
    func build(withListener listener: SellerDetailListener,
               seller: UIImage) -> SellerDetailRouting
}

final class SellerDetailBuilder: Builder<SellerDetailDependency>, SellerDetailBuildable {
    
    override init(dependency: SellerDetailDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SellerDetailListener,
               seller: UIImage) -> SellerDetailRouting {
        let component = SellerDetailComponent(dependency: dependency)
        let viewController = SellerDetailViewController()
        let interactor = SellerDetailInteractor(presenter: viewController,
                                                seller: seller)
        interactor.listener = listener
        
        let productDetailBuilder = ProductDetailBuilder(dependency: component)
        return SellerDetailRouter(interactor: interactor,
                                  viewController: viewController,
                                  productDetailBuilder: productDetailBuilder)
    }
}
