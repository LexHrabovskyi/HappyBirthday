//
//  DetailsViewModel.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class DetailsViewModel: DetailsModel {
    
    weak var delegate: DetailsDelegate?
    
    func getSavedData() -> SavedUserData? {
        
        // TODO:
        // get saved data from service
        // call "checkSavedData"
        return nil
    }
    
    func saveUserData(_ dataToSave: SavedUserData) {
        
        // TODO:
        // save data from service
        // call "checkSavedData"
        
    }
    
    private func checkSavedData(_ savedData: SavedUserData) {
        
        // if name and birthday are:
        //   empty: disable continue button for delegate
        //   not empty: enable continue button for delegate
        
    }
    
}
