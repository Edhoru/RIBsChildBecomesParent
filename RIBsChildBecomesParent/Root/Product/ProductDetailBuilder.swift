//
//  ProductBuilder.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol ProductDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ProductDetailComponent: Component<ProductDetailDependency>, SellerDetailDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ProductDetailBuildable: Buildable {
    func build(withListener listener: ProductDetailListener,
               product: UIImage) -> ProductDetailRouting
}

final class ProductDetailBuilder: Builder<ProductDetailDependency>, ProductDetailBuildable {

    override init(dependency: ProductDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ProductDetailListener,
               product: UIImage) -> ProductDetailRouting {
        let component = ProductDetailComponent(dependency: dependency)
        let viewController = ProductDetailViewController()
        let interactor = ProductDetailInteractor(presenter: viewController,
                                           product: product)
        interactor.listener = listener
        
        let sellerDetailBuilder = SellerDetailBuilder(dependency: component)
        return ProductDetailRouter(interactor: interactor,
                                   viewController: viewController,
                                   sellerDetailBuilder: sellerDetailBuilder)
    }
}
