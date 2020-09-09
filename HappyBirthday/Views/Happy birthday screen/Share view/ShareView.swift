//
//  ShaveView.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

@IBDesignable
class ShareView: UIView {

    weak var delegate: ImageForSharingPrepareDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle.main
        if let viewsToAdd = bundle.loadNibNamed("ShareView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }

    @IBAction func beginShareFlow(_ sender: UIButton) {
        
        delegate?.prepareImageToShare() { (result: Result<UIImage, Error>) in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageToShare):
                let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
                self.delegate?.present(activityViewController, animated: true, completion: nil)
            }
            
        }
        
    }
    
}
