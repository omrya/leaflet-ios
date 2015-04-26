//
//  LibraryAPI.swift
//  leaflet
//
//  Created by Mirai Akagawa on 4/6/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
   
    private let persistencyManager: PersistencyManager
    
    class var sharedInstance: LibraryAPI {
        
        struct Singleton {
            static let instance = LibraryAPI()
        }

        return Singleton.instance
    }

    override init() {
        persistencyManager = PersistencyManager()
        
        super.init()
        
    }
    
    func getPois() -> [FecPoi] {
        return persistencyManager.getPois()
    }
    
    func getPoiByBeaconMajor(major: Int) -> FecPoi? {
        var allPois = persistencyManager.getPois()
        for poi in allPois {
            if poi.beaconMajor == major {
                return poi
            }
        }
        return nil
    }
    
    func getPoiById(id: Int) -> FecPoi? {
        var allPois = persistencyManager.getPois()
        for poi in allPois {
            if poi.id == id {
                return poi
            }
        }
        return nil
    }
    
}
