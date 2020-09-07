//
//  DetailsScreenProtocols.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

protocol DetailsModel: class {
    
    var delegate: DetailsDelegate? { get set }
    
    
}

protocol DetailsDelegate: class {
    
    
    
}
