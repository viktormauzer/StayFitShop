//
//  ProfileViewModel.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 25.05.2022..
//

import SwiftUI
import CoreData

@MainActor final class ProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var address = ""
    @Published var zip = ""
    @Published var city = ""
    @Published var country = ""
    
    @Published var isShowingInvalidProfileError = false
    @Published var isShowingSuccessfullyCreatedProfile = false
    @Published var isShowingRemoveProfileAlert = false
    
    private func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !address.isEmpty,
              !zip.isEmpty,
              !city.isEmpty,
              !country.isEmpty else { return false }
        
        return true
    }
    
    func saveProfile(_ moc: NSManagedObjectContext) {
        if isValidProfile() {
            let newUser = User(context: moc)
            newUser.firstName = firstName
            newUser.lastName = lastName
            newUser.address = address
            newUser.zip = zip
            newUser.city = city
            newUser.country = country
            
            do {
                try moc.save()
                isShowingSuccessfullyCreatedProfile = true
            } catch {
                print(error.localizedDescription)
            }
        } else {
            isShowingInvalidProfileError = true
        }
    }
    
    func editProfile(_ user: User?, _ moc: NSManagedObjectContext) {
        guard let user = user else { return }

        if isValidProfile() {
            user.firstName = firstName
            user.lastName = lastName
            user.address = address
            user.zip = zip
            user.city = city
            user.country = country
            
            do {
                try moc.save()
                isShowingSuccessfullyCreatedProfile = true
            } catch {
                print(error.localizedDescription)
            }
        } else {

        }
    }
    
    func loadProfile(_ users: FetchedResults<User>) {
        for user in users {
            firstName = user.wrappedFirstName
            lastName = user.wrappedLastName
            address = user.wrappedAddress
            zip = user.wrappedZip
            city = user.wrappedCity
            country = user.wrappedCountry
        }
    }
    
    func deleteProfile(_ user: User?, _ moc: NSManagedObjectContext) {
        guard let user = user else { return }
        
        firstName = ""
        lastName = ""
        address = ""
        zip = ""
        city = ""
        country = ""
        
        moc.delete(user)
        
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
