//
//  ProfileView.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    @StateObject var viewModel = ProfileViewModel()
    
    var isModallyPresented: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                } header: {
                    Text("Personal information")
                }

                Section {
                    TextField("Address", text: $viewModel.address)
                    TextField("ZIP Code", text: $viewModel.zip)
                        .keyboardType(.numberPad)
                    TextField("City", text: $viewModel.city)
                    TextField("Country", text: $viewModel.country)
                } header: {
                    Text("Location information")
                }
                
                Section {
                    Button(users.isEmpty ? "Create Profile" : "Edit Profile") {
                        dismissKeyboard()
                        users.isEmpty ? viewModel.saveProfile(moc) : viewModel.editProfile(users.first, moc)
                        playHaptic(.success)
                    }

                    if !users.isEmpty {
                        Button("Remove Profile", role: .destructive) {
                            dismissKeyboard()
                            viewModel.isShowingRemoveProfileAlert = true
                            playHaptic(.warning)
                        }
                    }
                }
            }
            .disableAutocorrection(true)
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if isModallyPresented {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Dismiss & Order")
                        }
                    }
                }
                
                ToolbarItem(placement: .keyboard) {
                    Button {
                        dismissKeyboard()
                    } label: {
                        Label("Keyboard Dismiss", systemImage: "keyboard.chevron.compact.down")
                    }
                }
            }
            .onAppear {
                viewModel.loadProfile(users)
            }
            .alert("Delete Profile?", isPresented: $viewModel.isShowingRemoveProfileAlert) {
                Button("Delete", role: .destructive, action: {
                    viewModel.deleteProfile(users.first, moc)
                })
            } message: {
                Text("Are you certain you wish to delete your profile?")
            }
            .alert("Invalid Profile", isPresented: $viewModel.isShowingInvalidProfileError) {
                Button("OK", action: {})
            } message: {
                Text("All fields are required to successfully create a profile.")
            }
            .alert("Success!", isPresented: $viewModel.isShowingSuccessfullyCreatedProfile) {
                Button("OK", action: { dismissKeyboard() })
            } message: {
                Text("Your profile has been saved successfully!")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
