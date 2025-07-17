//
//  ContentView.swift
//  KeyChainDemo
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewVM()
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            HStack {
                TextField("Type here", text: $viewModel.keychainStr)
                    .modifier(TextFieldModifier())
                CustomButton(label: "Add To Keychain") {
                    Task {
                        await viewModel.addToKeychain()
                        showAlert = true
                    }
                }
            }

            HStack() {
                CustomButton(label: "Read from Keychain") {
                    Task {
                        await viewModel.readFromKeychain()
                        showAlert = true
                    }
                }
                Text(viewModel.valueFromKeychain)
                    .padding()
                    .font(.system(size: 15, weight: .bold))
            }

            HStack {
                TextField("Type here", text: $viewModel.updateKeyChainValue)
                    .modifier(TextFieldModifier())
                CustomButton(label: "Update Keychain") {
                    Task {
                        await viewModel.updateKeychain()
                        showAlert = true
                    }
                }
            }
            
            CustomButton(label: "Delete") {
                Task {
                    await viewModel.delete()
                    showAlert = true
                }
            }
            
        }
        .padding()
        .alert(viewModel.alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                viewModel.alertMessage = ""
            }
        }
    }
}

struct TextFieldModifier: ViewModifier
{
    func body(content: Content) -> some View
    {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(style: StrokeStyle(lineWidth: 1))
            )
    }
}

struct CustomButton: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .foregroundColor(.black)
                .padding(10)
                .background(.gray)
                .cornerRadius(10)
        }
    }
    
}

#Preview {
    ContentView()
}
