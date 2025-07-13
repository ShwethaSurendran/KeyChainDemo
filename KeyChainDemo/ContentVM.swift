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
    let keychain: KeyChainSwift = KeyChainSwift()
    
    @MainActor
    func addToKeychain() {
        Task {
            await keychain.setAccessGroup("N4BS4WAD88.com.ns.NewApp.KeyChainDemo")
            do {
                print(try await keychain.set(keychainStr, forKey: "com.test1",withAccessType: kSecAttrAccessibleAfterFirstUnlock))
                keychainStr = ""
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func readFromKeychain() {
        Task {
            do {
                let value = try await keychain.getValueFor("com.test1",withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
                valueFromKeychain = value
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func updateKeychain() {
        Task {
            do {
                let value = try await keychain.update(updateKeyChainValue,
                                                      forKey: "com.test1",
                                                      withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
            } catch {
                print(error)
            }
        }
    }
    
    func delete() {
        Task {
            do {
                let value = try await keychain.delete(forKey: "com.test1",
                                                      withAccessType: kSecAttrAccessibleAfterFirstUnlock)
                print(value)
            } catch {
                print(error)
            }
        }
    }
}
