//
//  Keychain.swift
//  Beering
//
//  Created by byeoungjik on 2023/08/30.
//

import Foundation
import Security

class KeyChain {
    // Create
//    enum KeychainError: Error{
//        case noPassword
//        case unexpectedPasswordData
//        case unhadledError(status: OSStatus)
//    }
    
    class func create(account: String, token: String) -> Bool{
        
        let createQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
//            kSecAttrService: server ,
            kSecAttrAccount: account,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        
//        SecItemDelete(createQuery)
        let upadateItem: Bool = {
            let status : OSStatus = SecItemAdd(createQuery, nil)
            if status == errSecSuccess{
                return true
            }
            else if status == errSecDuplicateItem{
                return update(account: account, newToken: token)
            }
            print("addItem Error : \(status.description)")
            return false
        }()
        
        return upadateItem
    }
    class func update(account: String, newToken: String) -> Bool{
        let query: [String: Any] = [kSecClass as String:kSecClassGenericPassword,
                                 kSecAttrAccount as String: account]
        
        let attributes: [String: Any] = [kSecValueData as String: newToken]
        
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr{
            print("Beering_Keychain: Token has changed")
            return true
        }
        else{
            print("Something went wrong trying to update the password")
            return false
        }
    }
    // Read
    class func retrieve(account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            //            kSecAttrService: server,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit as String: kSecMatchLimitOne,       // 중복되는 경우, 하나의 값만 불러오라는 의미
            kSecReturnAttributes as String: true
        ]
        
        var dataTypeRef: CFTypeRef?
        var retrieveToken: String = "Something went wrong trying to find the user in the keychain"
        
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            //Extract result
            if let existingItem = dataTypeRef as? [String: Any],
               let account = existingItem[kSecAttrAccount as String] as? String,
               let tokenData = existingItem[kSecValueData as String] as? Data,
               let token = String(data: tokenData, encoding: .utf8){
                print(account)
                retrieveToken = token
                print(retrieveToken)
                return retrieveToken
            }
        }
        else{
            print(retrieveToken)
        }
        return retrieveToken
    }
    // Delete
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}
