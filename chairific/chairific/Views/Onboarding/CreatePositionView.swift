//
//  CreatePositionView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct CreatePositionView: View {
    @State private var positionName = ""
    @State private var positionDescription = ""
    @State private var selectedSkills = Set<Skill>()
    @State private var newCulture = ""
    @State private var culture = [Hobby]()
    @State private var benefits = ""
    @State private var isAddingCulture = false

    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Chair setup")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    Group {
                        // Name of the position
                        Text("Name of the position")
                            .foregroundColor(.gray)
                        TextField("", text: $positionName)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        
                        // Short position description
                        Text("Short position description")
                            .foregroundColor(.gray)
                        TextField("", text: $positionDescription, axis: .vertical)
                            .lineLimit(3)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }

                    // Skills Section
                    VStack(alignment: .leading) {
                        Text("Skills (\(selectedSkills.count)/3):")
                            .foregroundColor(.gray)
                        ForEach(Array(selectedSkills), id: \.self) { skill in
                            HStack {
                                Text("+ \(skill.name)")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                Button(action: { selectedSkills.remove(skill) }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                        }
                        Button(action: { /* Ajouter logique pour sélectionner une compétence */ }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    
                    // Culture Section
                    VStack(alignment: .leading) {
                        Text("Culture")
                            .foregroundColor(.gray)
                        ForEach(culture, id: \.self) { hobby in
                            HStack {
                                Text("+ \(hobby.name)")
                                    .foregroundColor(.gray)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Button(action: { culture.removeAll { $0.id == hobby.id } }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                        }
                        if isAddingCulture {
                            HStack {
                                TextField("Enter a culture point", text: $newCulture)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                Button(action: addCulture) {
                                    Text("Add")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .background(Color.orange)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        Button(action: { isAddingCulture.toggle() }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }

                    // Benefits Section
                    VStack(alignment: .leading) {
                        Text("Benefits")
                            .foregroundColor(.gray)
                        TextField("", text: $benefits)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                    
                    // Create Button
                    HStack {
                        Spacer()
                        Button(action: { /* Action de création */ }) {
                            Text("Create")
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                        Spacer()
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }

    private func addCulture() {
        let trimmedCulture = newCulture.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedCulture.isEmpty {
            culture.append(Hobby(name: trimmedCulture))
            newCulture = ""
        }
    }
}


#Preview{
    CreatePositionView()
}
