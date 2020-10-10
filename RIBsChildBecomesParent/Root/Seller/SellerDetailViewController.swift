//
//  SellerDetailViewController.swift
//  RIBsChildBecomesParent
//
//  Created by Alberto Huerdo on 10/9/20.
//

import RIBs
import RxSwift
import UIKit

protocol SellerDetailPresentableListener: class {
    func close()
    func select(product: UIImage)
}

final class SellerDetailViewController: UIViewController {

    weak var listener: SellerDetailPresentableListener?
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Seller:"
        label.textColor = .white
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 44,
                                                              weight: .light)
        let buttonImage = UIImage(systemName: "xmark.circle.fill",
                                  withConfiguration: symbolConfiguration)?
            .withTintColor(.white,
                           renderingMode: .alwaysOriginal)
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Products:"
        label.textColor = .white
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
    
    
    //MARK: Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProperties()
        setupUI()
    }
    
    
    //MARK: Setup
    private func setupProperties() {
        closeButton.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
        button1.addTarget(self, action: #selector(handleButton1Tap), for: .touchUpInside)
        button2.addTarget(self, action: #selector(handleButton2Tap), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(productImageView)
        view.addSubview(subtitleLabel)
        view.addSubview(button1)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            productImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(greaterThanOrEqualTo: productImageView.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            button1.heightAnchor.constraint(equalTo: button1.widthAnchor),
            button1.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            button2.heightAnchor.constraint(equalTo: button2.widthAnchor),
            button2.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 16),
            button2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            button1.widthAnchor.constraint(equalTo: button2.widthAnchor)
        ])
    }
    
    
    //MARK: Actions
    @objc private func handleCloseTap() {
        listener?.close()
    }
    
    @objc private func handleButton1Tap() {
        listener?.select(product: #imageLiteral(resourceName: "hat_1"))
    }
    
    @objc private func handleButton2Tap() {
        listener?.select(product: #imageLiteral(resourceName: "hat_2"))
    }
}



//MARK: RIBs

extension SellerDetailViewController: SellerDetailPresentable {
    
    func display(seller: UIImage) {
        productImageView.image = seller
    }
    
}


extension SellerDetailViewController: SellerDetailViewControllable {
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true)
    }
    
    func dismiss(viewController: ViewControllable) {
        viewController.uiviewController.dismiss(animated: true)
    }
    
}
