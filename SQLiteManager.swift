import UIKit
import SQLite

struct DataBaseManager {
    
//    var user: Users!
    

    
    static var sharedInstance = DataBaseManager()
    
    static func shared() -> DataBaseManager {
        return DataBaseManager.sharedInstance
    }
    
    var dataBase: Connection!
    
    let userstable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let gender = Expression<Gender.RawValue>("gender")
    let phoneNum = Expression<String>("phoneNum")
    let address = Expression<String>("address")
    let password = Expression<String>("password")
    let image = Expression<Data>("image")
    
    let histroyTable = Table("history")
    let emailCashed = Expression<String>("emailCashed")
    let searchBarTextHisory = Expression<String>("searchBarTextHisory")
    let segmentedTextHistory = Expression<String>("segmentedTextHistory")



    ///////// connect to Data Base
    func setUpConnection() {
        do {
            let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDir.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let dataBasePath = try Connection(fileUrl.path)
            DataBaseManager.sharedInstance.dataBase = dataBasePath
        } catch {
            print(error)
        }
    }
    ///////// create Table
    func createUserTable() {
        
        let createTable = self.userstable.create {
            (table) in
            table.column(self.id ,primaryKey: true)
            table.column(self.email ,unique: true)
            table.column(self.name)
            table.column(self.gender)
            table.column(self.phoneNum)
            table.column(self.password)
            table.column(self.address)
            table.column(self.image)
        }
        do {
            try self.dataBase.run(createTable)
            print("create user Table")

        } catch {
            print(error)
        }
    }
    
    func createHistoryable() {
        
        let createHistoryTable = self.histroyTable.create {
            (table) in
            table.column(emailCashed ,unique: true)
            table.column(searchBarTextHisory)
            table.column(segmentedTextHistory)
        }
        do {
            try self.dataBase.run(createHistoryTable)
            print("create History Table")
        } catch {
            print(error)
        }
    }
    ///////// insert User
    func insertUser(user: Users) {
        
        createUserTable()
        let insertUser = self.userstable.insert(name <- user.name!, email <- user.email, phoneNum <- user.phoneNum!, address <- user.address, password <- user.password, image <- (user.image?.imageData)!,gender <- user.gender!.rawValue )
            print(name)
            do {
                try self.dataBase.run(insertUser)
            }
            catch{
                print(error)
            }

    }
    ///////// list User
    
    func checkSignInData(user: Users) -> Bool {
       var flag = false
        do {
            let users = try self.dataBase.prepare(self.userstable)
            
            for userr in users {
               
                if userr[self.email] == user.email && userr[self.password] == user.password {
                    print("done")
                    flag = true
                    break
                }
            }   
        }
        catch {
            print(error)
        }
        return flag
    }
    

    func checkUserByEmail(email : String, handle: @escaping (_ selected: Row) -> Void) {
        var selected: Row?
        do {
            
            let users = try self.dataBase.prepare(self.userstable)
            for userr in users {
                if userr[self.email] == email  {
                    selected = userr
                    break
                }
            }
        }
        catch {
            print(error)
        }
        handle(selected!)
    }
    
    
    
    func insertHistory(searth:String?, segmented:String?, email:String?) {
        guard let searchText = searth, let segmented = segmented, let emailCahsedd = email else {
            return
        }
        var exist = false
        
        do{
            let history = try self.dataBase.prepare(self.histroyTable)
            for row in history {
                let email = try row.get(self.emailCashed)
                if emailCahsedd == email {
                    exist = true
                    break
                }
            }
        } catch {
            
        }
        if exist {
            let history = self.histroyTable.filter(self.emailCashed == emailCahsedd).update(segmentedTextHistory <- segmented, searchBarTextHisory <- searchText)
            
            do {
                try self.dataBase.run(history)
                print("its exist")
            } catch {
                
            }
        } else {
            createHistoryable()
            let insert = self.histroyTable.insert(
                self.emailCashed <- emailCahsedd, segmentedTextHistory <- segmented, searchBarTextHisory <- searchText
                
            )
            do {
                try self.dataBase.run(insert)
                print("its not exist")
            } catch {
                
            }
        }
    }
    
    
    func getHistoryAndCallApi (emailCashed: String, complete : @escaping (_ search :String? ,_ segmented :String?) -> Void) {
        var selected :Row!
        do {
            
            let historyArr = try self.dataBase.prepare(self.histroyTable)
            for data in historyArr {
                let email = try data.get(self.emailCashed)
                if email ==  emailCashed {
                    selected = data
                }
            }
        } catch {
            print(error)
        }
        guard let selectedRow = selected  else {
            return
        }
        complete(selectedRow[self.searchBarTextHisory],selectedRow[self.segmentedTextHistory])
    }
}



