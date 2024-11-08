//
//  SkillsView.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import SwiftUI

struct Skill: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct Hobby: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct SkillsView: View {
    @State private var showError = false
    
    @State private var searchText = ""
    @State private var selectedSkills = Set<Skill>()
    @State private var isDropdownOpen = false
    private var maxNumberOfSkills = 5
    
    @State private var hobbies = [Hobby]()
    @State private var newHobby = ""
    private var maxNumberOfHobbies = 5
    @State private var isAddingHobby = false
    @State private var navigateToQuestioner = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    Text("Throne setup")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding(.top)
                        .padding(.bottom, 20)
                    VStack(alignment: .leading) {
                        Text("Hobbies (\(hobbies.count)/\(maxNumberOfHobbies)):")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                        ForEach(hobbies, id: \.self) { hobby in
                            HStack {
                                Text("+ \(hobby.name)")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                                
                                Button(action: { hobbies.removeAll { $0.id == hobby.id } }) {
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
                    
                    if isAddingHobby && hobbies.count < maxNumberOfHobbies{
                        HStack {
                            TextField("Enter a hobby", text: $newHobby)
                                .padding(8)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            
                            Button(action: addHobby) {
                                Text("Add")
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(newHobby.isEmpty || hobbies.count >= maxNumberOfHobbies)
                            .padding(.trailing)
                        }
                        .padding(.top, 4)
                    }
                }
                

            }
        }
    }
    
    private func addHobby() {
        let trimmedHobby = newHobby.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedHobby.isEmpty, hobbies.count < maxNumberOfHobbies {
            hobbies.append(Hobby(name: trimmedHobby))
            newHobby = ""
        }
    }
}

#Preview {
    SkillsView()
}
