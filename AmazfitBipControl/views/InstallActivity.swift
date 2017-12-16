//
//  InstallActivity.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

protocol InstallActivity{
    func getInfoText() -> String;
    
    func setInfoText(text: String);
    
    func setInstallEnabled(enable: Bool);
    
    func clearInstallItems();
    
    func setInstallItem(item: ItemWithDetails);
}
