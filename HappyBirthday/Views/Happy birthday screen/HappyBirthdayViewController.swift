//
//  HappyBirthdayViewController.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class HappyBirthdayViewController: UIViewController {

    private var viewModel: HappyBirthdayModel
    
    // MARK: - lifecycle
    init(viewModel: HappyBirthdayModel) {
        self.viewModel = viewModel
        super.init(nibName: "HappyBirthdayViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.generateRandomTheme()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO:
        // hide status bar
        // draw transparent circle
        // draw border
        // calculate camera icon position
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // TODO:
        // show status bar
    }
    
    // TODO: add action for taking photo
    // TODO: add action for getting screenshot
    // TODO: add action for dismiss
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HappyBirthdayViewController: HappyBirthdayDelegate {
    
    func update(withTheme: ThemeSet) {
        
        // TODO: update elements:
        // 1. main image
        // 2. placeholder
        // 3. camera icon
        // 4. background color
        // 5. save border color
        // 6. place the nanit image at the right place
        
    }
    
    func showError(message: String) {
        // TODO: create alert and show error message
    }
    
}
