//
//  PumpkinDetailBuilder.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs

protocol PumpkinDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PumpkinDetailComponent: Component<PumpkinDetailDependency>, HatDetailDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol PumpkinDetailBuildable: Buildable {
    func build(withListener listener: PumpkinDetailListener,
               pumpkin: UIImage) -> PumpkinDetailRouting
}

final class PumpkinDetailBuilder: Builder<PumpkinDetailDependency>, PumpkinDetailBuildable {
    
    override init(dependency: PumpkinDetailDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: PumpkinDetailListener,
               pumpkin: UIImage) -> PumpkinDetailRouting {
        let component = PumpkinDetailComponent(dependency: dependency)
        let viewController = PumpkinDetailViewController()
        let interactor = PumpkinDetailInteractor(presenter: viewController,
                                                pumpkin: pumpkin)
        interactor.listener = listener
        
        let hatDetailBuilder = HatDetailBuilder(dependency: component)
        return PumpkinDetailRouter(interactor: interactor,
                                  viewController: viewController,
                                  hatDetailBuilder: hatDetailBuilder)
    }
}
