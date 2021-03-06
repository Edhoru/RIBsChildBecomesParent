//
//  RootViewController.swift
//  Roomi
//
//  Created by Alberto Huerdo on 10/4/20.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    func select(hat: UIImage)
}

final class RootViewController: UIViewController {

    //MARK: RIBs
    weak var listener: RootPresentableListener?
    
    //MARK: UI
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = """
This project presents a common scenario of apps that present a list of objects to select and see it's details (Think of these as products), from the details screen you can see a list of other objects (let's think about those as sellers) to pick from, from the seller's details you see a list of all the producs (type 1) they sell, and so on.

Flow:
1. From this Root RIBs pick a hat to open the child RIB called 'Hat'

2. From the 'Hat' RIB, you can see a list of pumpkins that can wear this hat

3. When you pick a pumpkin you open the 'Pumpkin' RIB as a child of 'Hat', this RIB display all the hats the pumpkin can wear.

4. From that list of hats you can pick a hat and open the 'Hat' RIB now as a child of 'Pumpkin'

This behavior can continue for ever, since the mock data has 2 pumpkins (pumpkins) and both can wear the same 2 hats. Is this the right way to handle this scenario?

Thanks
"""
        return label
    }()
    
    let button1: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "hat_1"), for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "hat_2"), for: .normal)
        return button
    }()
    
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProperties()
        setupUI()
    }
    
    
    //MARK: Setup
    private func setupProperties() {
        button1.addTarget(self, action: #selector(handleButton1Tap), for: .touchUpInside)
        button2.addTarget(self, action: #selector(handleButton2Tap), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(descriptionLabel)
        view.addSubview(button1)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            button1.heightAnchor.constraint(equalTo: button1.widthAnchor),
            button1.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            button2.heightAnchor.constraint(equalTo: button2.widthAnchor),
            button2.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 16),
            button2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            button1.widthAnchor.constraint(equalTo: button2.widthAnchor)
        ])
    }
    
    
    //MARK: Actions
    @objc private func handleButton1Tap() {
        listener?.select(hat: #imageLiteral(resourceName: "hat_1"))
    }
    
    @objc private func handleButton2Tap() {
        listener?.select(hat: #imageLiteral(resourceName: "hat_2"))
    }
    
}


//MARK RIBs

extension RootViewController: RootPresentable {
    
}

extension RootViewController: RootViewControllable {
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true)
    }
    
    func dismiss(viewController: ViewControllable) {
        viewController.uiviewController.dismiss(animated: true)
    }
    
}
