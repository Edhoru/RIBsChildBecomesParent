//
//  HatBuilder.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol HatDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class HatDetailComponent: Component<HatDetailDependency>, PumpkinDetailDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol HatDetailBuildable: Buildable {
    func build(withListener listener: HatDetailListener,
               hat: UIImage) -> HatDetailRouting
}

final class HatDetailBuilder: Builder<HatDetailDependency>, HatDetailBuildable {

    override init(dependency: HatDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HatDetailListener,
               hat: UIImage) -> HatDetailRouting {
        let component = HatDetailComponent(dependency: dependency)
        let viewController = HatDetailViewController()
        let interactor = HatDetailInteractor(presenter: viewController,
                                           hat: hat)
        interactor.listener = listener
        
        let pumpkinDetailBuilder = PumpkinDetailBuilder(dependency: component)
        return HatDetailRouter(interactor: interactor,
                                   viewController: viewController,
                                   pumpkinDetailBuilder: pumpkinDetailBuilder)
    }
}
