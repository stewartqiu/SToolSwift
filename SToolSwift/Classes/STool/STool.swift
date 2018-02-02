//
//  STool.swift
//  SToolSwift
//
//  Created by SchoolDroid on 1/31/18.
//

import Foundation
import UIKit
import Contacts
import ContactsUI
import Photos
import PhotosUI


public class STool {
    
    public static func fetchContacts () -> [CNContact]{
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactPhoneNumbersKey] as! [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        var contacts = [CNContact]()
        
        fetchRequest.mutableObjects = false
        fetchRequest.unifyResults = true
        fetchRequest.sortOrder = .userDefault
        
        let contactStoreID = CNContactStore().defaultContainerIdentifier()
        print("\(contactStoreID)")
        
        do {
            
            try CNContactStore().enumerateContacts(with: fetchRequest) { (contact, stop) -> Void in
                contacts.append(contact)
            }
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
        
        return contacts
    }
    
    
    
    
    
    
    public static func setAppLanguage (kode : String){
        UserDefaults.standard.set([kode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    // TODO:- Pelajari
    public static func openDocumentPicker (sender: UIViewController) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [], in: .import)
        sender.present(documentPicker, animated: true, completion: nil)
    }
    
    

    
    
    
    public static func openKamera (sender: UIViewController , editable : Bool) {
        // Protocol UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = sender as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if editable {
            imagePicker.allowsEditing = true
        } else {
            imagePicker.allowsEditing = false
        }
        imagePicker.sourceType = .camera
        sender.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    public static func openPhotoLibrary(sender: UIViewController , editable : Bool) {
        // Protocol UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = sender as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if editable {
            imagePicker.allowsEditing = true
        } else {
            imagePicker.allowsEditing = false
        }
        imagePicker.sourceType = .photoLibrary
        sender.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    public static func getNumberFromContactObj (contact : CNContact) -> String {
        return (contact.phoneNumbers[0].value).value(forKey: "digits") as! String
    }
    
    
    
    
    
    public static func randomNumber (length : Int) -> String {
        
        var string = ""
        
        for _ in 1 ... length {
            string = string + String(arc4random_uniform(10))
        }
        
        return string
    }

    
    
    public static func randomString(length: Int) -> String {
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    
    
    
    public static func getNow (format : String) -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        let today = formatter.string(from: date)
        
        return today
        
    }
    
    
    
    
    public static func toSetting (sender : UIViewController ,title : String , message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Setting", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Batalkan", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        sender.present(alertController, animated: true, completion: nil)
    }
    
}
