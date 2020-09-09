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
    @IBOutlet weak var cameraIconImageView: UIImageView!
    
    fileprivate var imagePicker: ImagePicker!
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
        replaceAndShowCameraButton()
        setupPhotoChooseForCameraIcon()
        showViewsWithAnimation()
        
    }
    
    private func configureUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        childPhotoImageView.alpha = 0.01
        cameraIconImageView.alpha = 0.01
        
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
        
    }
    
    private func drawBorderForChildPhoto() {
        
        guard let childPhotoBorderColor = borderColor?.cgColor else { return }
        childPhotoImageView.layer.borderWidth = 8
        childPhotoImageView.layer.borderColor = childPhotoBorderColor
        
    }
    
    private func replaceAndShowCameraButton() {
        
        let photoCenterX = childPhotoImageView.frame.origin.x + childPhotoImageView.frame.width / 2
        let photoCenterY = childPhotoImageView.frame.origin.y + childPhotoImageView.frame.height / 2
        let photoRadius = childPhotoImageView.frame.width / 2
        
        let angle: CGFloat = 315
        let fourthyFiveDegreesInRad: CGFloat = angle * CGFloat(Double.pi / 180)
        var cameraOriginX = photoCenterX + photoRadius * CGFloat(cos(fourthyFiveDegreesInRad))
        var cameraOriginY = photoCenterY + photoRadius * CGFloat(sin(fourthyFiveDegreesInRad))
        
        if 0...90 ~= Int(angle) || 270...360 ~= Int(angle) {
            cameraOriginX -= cameraIconImageView.frame.width / 2
            cameraOriginY -= cameraIconImageView.frame.height / 2
        } else {
            // TODO:
            print("should recalculate with center of the icon")
        }
        
        cameraIconImageView.frame.origin = CGPoint(x: cameraOriginX, y: cameraOriginY)
        
    }
    
    private func setupPhotoChooseForCameraIcon() {
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        cameraIconImageView.isUserInteractionEnabled = true
        cameraIconImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
    private func choosePhoto(_ sender: UIImageView) {
        self.imagePicker.present(from: sender)
    }
    
    private func showViewsWithAnimation() {
        
        UIView.animate(withDuration: 0.4) {
            self.childPhotoImageView.alpha = 1.0
            self.cameraIconImageView.alpha = 1.0
        }
        
    }
    
    // TODO: add action for getting screenshot

    // MARK: actions
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
        cameraIconImageView.image = withTheme.cameraIconImage
        
    }
    
    func showError(message: String) {
        // TODO: create alert and show error message
    }
    
}

extension HappyBirthdayViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        
        guard let newPhotoData = image?.pngData() else { return }
        viewModel.saveNewChildPhoto(imageData: newPhotoData)
        childPhotoImageView.image = image
        
    }
    
}
