//
//  SettingLite.swift
//  SToolSwift
//
//  Created by SchoolDroid on 2/1/18.
//

import SQLite


class DatabaseLite {
    static let connection : Connection! = {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("schooldroidSetting").appendingPathExtension("sqlite3")               // MARK : CHANGE
            let database = try Connection(fileUrl.path)
            return database
        } catch {
            return nil
        }
    } ()
}

class SettingLite {
    
    var database = DatabaseLite.connection!
    
    init() {
    }
    
    let namaTable = Table("setting")
    let keyfile_key = Expression<String>("keyfile")
    let value_key = Expression<String>("value")
    
    func createTable () -> Bool {
        
        let createTable = self.namaTable.create { (table) in
            table.column(self.keyfile_key, primaryKey: true)
            table.column(self.value_key)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func insertData (keyfile : String , value : String) -> Bool {
        
        let _ = createTable()
        
        let res = getFiltered(keyfile: keyfile)
        
        if  res == nil {
            print("new")
            let insertData = self.namaTable.insert(self.keyfile_key <- keyfile, self.value_key <- value)
            
            do{
                try self.database.run(insertData)
                return true
            } catch {
                print("Error : \(error)")
                return false
            }
            
        } else {
            print("update")
            let data = self.namaTable.filter(self.keyfile_key == keyfile)
            
            do {
                let update = data.update(self.value_key <- value)
                try self.database.run(update)
                
                return true
            }
            catch {
                print("Error : \(error)")
                return false
            }
        }
        
    }
    
    func deleteData (_ keyfile : String) -> Bool{
        
        let data = self.namaTable.filter(self.keyfile_key == keyfile)
        let deleteData = data.delete()
        do {
            try self.database.run(deleteData)
            return true
        } catch {
            print("Error : \(error)")
            return false
        }
        
    }
    
    
    
    func getFiltered(keyfile : String) -> String? {
        
        let filter = self.namaTable.filter(keyfile_key == keyfile)
        do{
            let data = try self.database.prepare(filter)
            var result : String?
            for res in data {
                result = res[self.value_key]
            }
            return result
        } catch {
            print("Error : \(error)")
            return nil
        }
        
    }
    
    
}
