//
//  CreateView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = CreateViewModel()
    @State private var showLoading: Bool = false
    @State private var formIsValid: Bool = true
    @State private var formError: String = ""
    let onSuccess: () -> Void
    
    var body: some View {
        VStack {
            form
            submit
        }
        .navigationTitle("Create")
        .toolbar {
            ToolbarItem {
                Button("Done") {
                    dismiss()
                }
                .disabled(vm.state == .loading)
                .accessibilityIdentifier("doneButton")
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error, actions: {
            Button("Ok") {}
            Button("Retry") {
                Task { await vm.createPerson() }
            }
        })
        .overlay {
            if showLoading {
                LoadingView()
            }
        }
        .embedNavigation()
        .onChange(of: vm.state, perform: { newValue in
            if newValue == .success {
                HapticManager.shared.trigger(.medium)
                showLoading.toggle()
                dismiss()
                onSuccess()
            } else {
                showLoading.toggle()
            }
        })
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {}
    }
}

extension CreateView {
    var form: some View {
        Form {
            TextField("First Name", text: $vm.newPerson.firstName)
            TextField("Last Name", text: $vm.newPerson.lastName)
            TextField("Job", text: $vm.newPerson.job)
            if formIsValid == false {
                Text(formError)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    
    var submit: some View {
        Button("Submit") {
            formIsValid = true
            let error = CreateValidator.validatePerson(vm.newPerson)
            if error == nil {
                Task { await vm.createPerson() }
            } else {
                formError = error?.localizedDescription ?? "Invalid form details"
                formIsValid = false
            }
        }
        .accessibilityIdentifier("submitButton")
    }
}
