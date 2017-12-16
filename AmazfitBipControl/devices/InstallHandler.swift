//
//  InstallHandler.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 14.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

/**
 * Interface for the UI side of certain kinds of installation of things on the
 * gadget device. The actual element to install will be passed in the constructor.
 */
import UIKit

protocol InstallHandler {
    /**
     * Returns true if this handler is able to install the element.
     * #validateInstallation may only be called if this method returned true.
     */
    func isValid() -> Bool;
    
    /**
     * Checks whether the installation of the 'element' on the device is possible
     * and configures the InstallActivity accordingly (sets helpful texts,
     * enables/disables the "Install" button, etc.
     * <p/>
     * Note: may only be called if #isValid previously returned true.
     *
     * @param installActivity the activity to interact with
     * @param device          the device to which the element shall be installed
     */
    func validateInstallation(installActivity: InstallActivity, device: GBDevice);
    
    /**
     * Allows device specific code to be executed just before the installation starts
     */
    func onStartInstall(device: GBDevice);
}
