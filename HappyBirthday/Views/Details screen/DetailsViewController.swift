//
//  DetailsViewController.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var childNameTextField: UITextField!
    @IBOutlet weak var childBirthdayDatePicker: UIDatePicker!
    @IBOutlet weak var childImageView: UIImageView!
    @IBOutlet weak var showBirthdayScreenButton: UIButton!
    @IBOutlet weak var imageAddInfoLabel: UILabel!
    
    private let viewModel: DetailsModel
    private var birthdayDidChange = false
    fileprivate var imagePicker: ImagePicker!
    
    // MARK: lifecycle
    init(viewModel: DetailsModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        loadSavedData()
        configureUI()
        setupPhotoChooseForImage()
        childNameTextField.delegate = self
        
        
    }
    
    private func loadSavedData() {
        
        guard let savedData = viewModel.getSavedData() else { return }
        childNameTextField.text = savedData.name
        childBirthdayDatePicker.date = savedData.dateOfBirth
        birthdayDidChange = true
        guard let childPhotoData = savedData.photoData else { return }
        childImageView.image = UIImage(data: childPhotoData)
        
    }
    
    private func configureUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        childNameTextField.placeholder = "Please, enter child name"
        
        let today = Date()
        let twelveYearsAgo = Calendar.current.date(byAdding: .year, value: -12, to: today)
        childBirthdayDatePicker.maximumDate = today
        childBirthdayDatePicker.minimumDate = twelveYearsAgo
        
        showBirthdayScreenButton.layer.cornerRadius = 4
        
        let childImagePresent = childImageView.image != nil
        childImageView.layer.borderColor = childImagePresent ? nil : UIColor.gray.cgColor
        childImageView.layer.borderWidth = childImagePresent ? 0 : 1
        imageAddInfoLabel.isHidden = childImagePresent
        
    }
    
    private func setupPhotoChooseForImage() {
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        childImageView.isUserInteractionEnabled = true
        childImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
    private func choosePhoto(_ sender: UIImageView) {
        self.imagePicker.present(from: sender)
    }
    
    // MARK: actions
    @IBAction func showBirthdayScreenAction(_ sender: UIButton) {
        
        guard let savedData = viewModel.getSavedData() else {
            print("should not get this case")
            return
        }
        
        let birhdayModel = HappyBirthdayViewModel(childData: savedData)
        let birthdayViewController = HappyBirthdayViewController(viewModel: birhdayModel)
        birthdayViewController.modalPresentationStyle = .overCurrentContext
        self.present(birthdayViewController, animated: true)
        
    }
    
    @IBAction func birthdayChanged(_ sender: UIDatePicker) {
        birthdayDidChange = true
        saveNewData()
    }
    
    private func saveNewData() {
        
        guard let newName = childNameTextField.text, birthdayDidChange else { return }
        let newBirthday = childBirthdayDatePicker.date
        let newPhoto = childImageView.image?.pngData()
        
        let savedData = SavedUserData(name: newName, dateOfBirth: newBirthday, photoData: newPhoto)
        viewModel.saveUserData(savedData)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveNewData()
        return true
    }
    
}

extension DetailsViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        childImageView.image = image
        saveNewData()
        configureUI()
    }
    
}
