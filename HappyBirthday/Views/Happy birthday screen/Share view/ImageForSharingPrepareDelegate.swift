//
//  SharePrepareDelegate.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

protocol ImageForSharingPrepareDelegate: UIViewController {
    func prepareImageToShare(completion: @escaping (Result<UIImage, Error>) -> Void)
}
