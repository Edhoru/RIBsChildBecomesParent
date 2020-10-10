//
//  File.swift
//  Roomi
//
//  Created by Alberto Huerdo on 10/4/20.
//

import Foundation

import RIBs

class AppComponent: Component<EmptyDependency>,
                    RootDependency
{
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
