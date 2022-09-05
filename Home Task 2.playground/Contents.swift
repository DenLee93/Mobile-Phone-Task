import UIKit


protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findMyImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

class Mobile :Hashable, MobileStorage {
    
    var name : String
    
    init(name:String){
        self.name = name
    }
    
    var imei: String
    var model: String
    
    init(imeiNumber:String,modelNumber:String) {
        self.imei = imeiNumber
        self.model = modelNumber
    }
        
   
    enum StorageError:Error {
        case saveError
        case deleteError
    }
    
    private var storage = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
    return storage
    }
    
    func findMyImei(_ imei: String) -> Mobile? {
    let array = Array(storage)
    return array.filter {$0.imei == imei}.first
    }

    func save(_ mobile: Mobile) throws -> Mobile {
        if storage.contains(mobile) {
            StorageError.saveError
        } else {
    let result = storage.insert(mobile)
    return result.memberAfterInsert
    }
    
    func delete(_ product: Mobile) throws {
        if storage.contains(mobile) {
            storage.remove(product)
        } else {
            StorageError.deleteError
        }
        
    }

    func exists(_ product: Mobile) -> Bool {
        return storage.contains(product)
    }
   
}
}

