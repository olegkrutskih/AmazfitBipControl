//
//  UriHelper.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 15.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import Foundation

class UriHelper {
    private var uri: NSURL;

    private var fileName: String = "";
    private var fileSize: CLong = 0;
    private var file: FileHandle = FileHandle.init();
    
    init(uri: NSURL) {
        self.uri = uri
    }
    
    func getUri() -> NSURL{
        return self.uri
    }
    
    func get(uri: NSURL) -> UriHelper {
        let helper: UriHelper = UriHelper(uri: uri)
        helper.resolveMetadata()
        return helper
    }
    
//    func openInputStream() -> InputStream {
//    ContentResolver cr = context.getContentResolver();
//    InputStream inputStream = cr.openInputStream(uri);
//    if (inputStream != null) {
//    return new BufferedInputStream(inputStream);
//    }
//    throw new FileNotFoundException("Unable to open inputstream for " + uri);
//    }

    func getFileSize() -> CLong {
        return self.fileSize
    }
    
    func getFileName() -> String {
        return fileName
    }
    
    func getFile() -> FileHandle {
        return file
    }
    
    
    
    private func resolveMetadata(){
        
    }
    
}
