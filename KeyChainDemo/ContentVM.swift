//
//  ContentVM.swift
//  KeyChainDemo
//
//

import Foundation
import KeyChainSwift

class ContentViewVM: ObservableObject {
    @Published var keychainStr:String = ""
    @Published var valueFromKeychain:String = ""
    @Published var updateKeyChainValue:String = ""
    @Published var alertMessage:String = ""
    let keychain: KeyChainSwift = KeyChainSwift()
    
    @MainActor
    func addToKeychain() async {
        //Keychain will get this value from entitlements if not set manually
//            await keychain.setAccessGroup("N4BS4WAD88.com.ns.NewApp.KeyChainDemo")
        
            do {
                print(try await keychain.set(keychainStr, forKey: "com.test1",withAccessType: kSecAttrAccessibleAfterFirstUnlock))
                keychainStr = ""
                alertMessage = "Successfully added"
            } catch {
                alertMessage = error.localizedDescription
                print(error)
            }
    }
    
    @MainActor
    func readFromKeychain() async {
            do {
                let value = try await keychain.getValueFor("com.test1",withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
                valueFromKeychain = value
                alertMessage = "Successfully read"
            } catch {
                alertMessage = error.localizedDescription
                print(error)
            }
    }
    
    @MainActor
    func updateKeychain() async {
            do {
                let value = try await keychain.update(updateKeyChainValue,
                                                      forKey: "com.test1",
                                                      withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
                alertMessage = "Successfully updated"
            } catch {
                alertMessage = error.localizedDescription
                print(error)
            }
    }
    
    @MainActor
    func delete() async {
            do {
                let value = try await keychain.delete(forKey: "com.test1",
                                                      withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
                alertMessage = "Successfully deleted"
            } catch {
                alertMessage = error.localizedDescription
                print(error)
            }
    }
}
