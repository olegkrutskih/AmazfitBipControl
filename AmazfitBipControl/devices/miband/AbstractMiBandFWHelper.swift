////
////  AbstractMiBandFWHelper.swift
////  AmazfitBipControl
////
////  Created by Круцких Олег on 15.12.2017.
////  Copyright © 2017 Круцких Олег. All rights reserved.
////
//
//import Foundation
//
//class AbstractMiBandFWHelper {
//    private var fw: [UInt8];
//
//    init(uri: NSURL) {
//        let uriHelper: UriHelper = UriHelper.init(uri: uri)
//        let pebblePattern: String = ".*\\.(pbw|pbz|pbl)";
//
////        if uriHelper.getFileName(). matches(pebblePattern) {
////            throw new IOException("Firmware has a filename that looks like a Pebble app/firmware.");
////        }
////
////        try (InputStream in = new BufferedInputStream(uriHelper.openInputStream())) {
////            this.fw = FileUtils.readAll(in, 1024 * 1024); // 1 MB
////            determineFirmwareInfo(fw);
////        } catch (IOException ex) {
////            throw ex; // pass through
////        } catch (IllegalArgumentException ex) {
////            throw new IOException("This doesn't seem to be a Mi Band firmware: " + ex.getLocalizedMessage(), ex);
////        } catch (Exception e) {
////            throw new IOException("Error reading firmware file: " + uri.toString(), e);
////        }
//
//    }
//}

