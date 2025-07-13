//
//  ContentView.swift
//  KeyChainDemo
//
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewVM()
    var body: some View {
        VStack {
            TextField("Add to Key chain", text: $viewModel.keychainStr)
                .frame(height: 50)
                .border(.gray)
            Button("Add To Key Chain") {
                viewModel.addToKeychain()
            }
            .padding(.top)
            
            Text(viewModel.valueFromKeychain)
                .padding()
            Button("Read from Key Chain") {
                viewModel.readFromKeychain()
            }
            .padding(.top)
            
            TextField("Update Key chain", text: $viewModel.updateKeyChainValue)
                .frame(height: 50)
                .border(.gray)
            Button("Update Key Chain") {
                viewModel.updateKeychain()
            }
            .padding(.top)
            
            Button("Delete") {
                viewModel.delete()
            }
            .padding(.top)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
