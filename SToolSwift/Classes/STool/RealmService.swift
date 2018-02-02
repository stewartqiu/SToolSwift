//
//  RealmService.swift
//  SToolSwift
//
//  Created by SchoolDroid on 2/2/18.
//

import Foundation
import RealmSwift

public class RealmService {
    private init () {}
    
    public static let shared = RealmService()
    public static let notifName = NSNotification.Name("RealmError")
    
    
    
    public var realm = try! Realm()
    
    
    public func insert <T : Object> (_ object : T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch {
            post(error)
        }
        
    }
    
    
    
    public func delete <T : Object> (_ object : T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    
    public func post(_ error : Error) {
        NotificationCenter.default.post(name: RealmService.notifName, object: error)
    }
    
    
    
    
    public func observeRealmErrors (in vc : UIViewController, completion : @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: RealmService.notifName, object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    
    
    public func stopObservingErrors (in vc : UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: RealmService.notifName, object: nil)
    }
}
