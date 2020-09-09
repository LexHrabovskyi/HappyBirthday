//
//  HappyBirthdayViewController.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class HappyBirthdayViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var childPhotoImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainThemeImageView: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var ageImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    private var viewModel: HappyBirthdayModel
    private var borderColor: UIColor?
    
    // MARK: - lifecycle
    init(viewModel: HappyBirthdayModel) {
        self.viewModel = viewModel
        super.init(nibName: "HappyBirthdayViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.generateRandomTheme()
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setChildPhotoIntoCircle()
        drawBorderForChildPhoto()
        
    }
    
    private func configureUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        childPhotoImageView.alpha = 0.01
        
        let childAge = viewModel.getChildAge()
        ageImageView.image = AgeImages.getImage(forAge: childAge)
        
        let designedName = viewModel.childData.name.uppercased()
        greetingLabel.text = "TODAY \(designedName) IS"
        
        switch childAge {
        case .month(let months):
            ageLabel.text = "MONTH\(months == 1 ? "" : "S") OLD!"
        case .year(let fullYears), .halfAYear(let fullYears):
            ageLabel.text = "YEAR\(fullYears == 1 ? "" : "S") OLD!"
        }
        
        
    }
    
    private func setChildPhotoIntoCircle() {
        
        childPhotoImageView.layer.cornerRadius = childPhotoImageView.frame.height / 2
        childPhotoImageView.clipsToBounds = true
        UIView.animate(withDuration: 0.4) {
            self.childPhotoImageView.alpha = 1.0
        }
        
    }
    
    private func drawBorderForChildPhoto() {
        
        guard let childPhotoBorderColor = borderColor?.cgColor else { return }
        childPhotoImageView.layer.borderWidth = 8
        childPhotoImageView.layer.borderColor = childPhotoBorderColor
        
    }
    
    // TODO: add action for taking photo
    // TODO: add action for getting screenshot

    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HappyBirthdayViewController: HappyBirthdayDelegate {
    
    func update(withTheme: ThemeSet) {
        
        backgroundView.backgroundColor = withTheme.backgroundColor
        mainThemeImageView.image = withTheme.mainImage
        
        if let childPhotoData = viewModel.childData.photoData,
            let childPhoto = UIImage(data: childPhotoData) {
            
            childPhotoImageView.image = childPhoto
            
        } else {
            childPhotoImageView.image = withTheme.placeholderImage
        }
        
        borderColor = withTheme.circleBordercolor
        
        
    }
    
    func showError(message: String) {
        // TODO: create alert and show error message
    }
    
}
