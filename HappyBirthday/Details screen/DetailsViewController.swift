//
//  DetailsViewController.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let viewModel: DetailsModel
    
    // MARK: lifecycle
    init(viewModel: DetailsModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
        
    }
    
    private func configureUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
