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
    @IBOutlet weak var shareButtonView: ShareView!
    
    fileprivate var imagePicker: ImagePicker!
    let viewModel: HappyBirthdayModel
    
    // MARK: - lifecycle
    init(viewModel: HappyBirthdayModel) {
        self.viewModel = viewModel
        super.init(nibName: "HappyBirthdayViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        shareButtonView.delegate = self
        viewModel.generateRandomTheme()
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        setChildPhotoIntoCircle()
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

    // MARK: actions
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HappyBirthdayViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        
        guard let newPhotoData = image?.pngData() else { return }
        viewModel.saveNewChildPhoto(imageData: newPhotoData)
        childPhotoImageView.image = image
        
    }
    
}

extension HappyBirthdayViewController: ImageForSharingPrepareDelegate {
    
    func prepareImageToShare(completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let bounds = view.bounds
        cameraIconImageView.isHidden = true
        closeButton.isHidden = true
        shareButtonView.isHidden = true
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        cameraIconImageView.isHidden = false
        closeButton.isHidden = false
        shareButtonView.isHidden = false
        
        if let screenshot = img {
            completion(.success(screenshot))
        } else {
            completion(.failure(NSError(domain: "Cannot make screenshot", code: 0)))
        }
        
        
    }
    
}
