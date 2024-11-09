//
//  SkillsView.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import SwiftUI

struct CultureView: View {
    
    @State private var showError = false
    
    @State private var cultures: [String] = []
    @State private var newCulture = ""
    private var maxNumberOfCulture = 5
    
    @State private var benefits: [String] = []
    @State private var newBenefit = ""
    private var maxNumberOfBenefits = 5
    
    @State private var navigateToFirstPosition = false
    @State private var errorMessage = ""
    
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Table setup")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding(.top)
                        .padding(.bottom, 20)
                    VStack(alignment: .leading) {
                        Text("Culture (\(cultures.count)/\(maxNumberOfCulture)):")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                        
                        ForEach(cultures, id: \.self) { culture in
                            HStack {
                                Text("+ \(culture)")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                Button(action: { cultures.removeAll { $0 == culture} }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 10)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                    }
                    .padding(.bottom, 4)
                    
                    if cultures.count < maxNumberOfCulture {
                        HStack {
                            TextField("Enter a culture", text: $newCulture)
                                .padding(8)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            
                            Button(action: addCulture) {
                                Text("Add")
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(newCulture.isEmpty || cultures.count >= maxNumberOfCulture)
                            .padding(.trailing)
                        }
                        .padding(.top, 4)
                    }
            
                    VStack(alignment: .leading) {
                        Text("Benefits (\(benefits.count)/\(maxNumberOfBenefits)):")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                        
                        ForEach(benefits, id: \.self) { benefit in
                            HStack {
                                Text("+ \(benefit)")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                Button(action: { benefits.removeAll { $0 == benefit } }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 10)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                    }
                    .padding(.bottom, 4)
                    
                    if benefits.count < maxNumberOfBenefits {
                        HStack {
                            TextField("Enter a benefit", text: $newBenefit)
                                .padding(8)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            
                            Button(action: addBenefit) {
                                Text("Add")
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(newBenefit.isEmpty || benefits.count >= maxNumberOfBenefits)
                            .padding(.trailing)
                        }
                        .padding(.top, 4)
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        isLoading = true
                        showError = false
                        uploadCompanyCultureAndBenefits(culture: cultures, benefits: benefits) { result in
                            switch result {
                            case .success:
                                isLoading = false
                                navigateToFirstPosition = true
                                print("Data uploaded successfully.")
                            case .failure(let error):
                                isLoading = false
                                errorMessage = "Failed to upload data: \(error)"
                                showError = true
                                print("Failed to upload data: \(error)")
                            }
                        }
                    }) {
                        Text("Continue")
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
                
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 18))
                        .padding(.top, 20)
                }
            }
            .navigationDestination(isPresented: $navigateToFirstPosition) {
                CreatePositionView(isFirstPositions: true)
            }
            .padding(.horizontal, 25)
            .navigationBarBackButtonHidden(true)
            
            if isLoading {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                        Text("Saving your data...")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
        }

    }
    
    private func addCulture() {
        let trimmedCulture = newCulture.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedCulture.isEmpty, cultures.count < maxNumberOfCulture {
            cultures.append(trimmedCulture)
            newCulture = ""
        }
    }
    
    private func addBenefit() {
        let trimmedBenefit = newBenefit.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedBenefit.isEmpty, benefits.count < maxNumberOfBenefits {
            benefits.append(trimmedBenefit)
            newBenefit = ""
        }
    }
    
    private func uploadCompanyCultureAndBenefits(culture: [String], benefits: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let companyData: [String: [String]] = [
            "culture": cultures,
            "benefits": benefits
        ]
        
        FirestoreManager.shared.updateCompany(fromId: CompanyManager.shared.companyName!, data: companyData) { result in
            switch result {
            case .success:
                CompanyManager.shared.culture = cultures
                CompanyManager.shared.benefits = benefits
                print("Company culture and benefits successfully updated.")
                completion(.success(()))
            case .failure(let error):
                print("Error updating Company culture and benefits: \(error)")
                completion(.failure(error))
            }
        }
    }
}

struct CultureView_Previews: PreviewProvider {
    static var previews: some View {
        CultureView()
    }
}
