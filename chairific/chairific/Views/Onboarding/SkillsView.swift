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
    @State private var skills = [
        "Develop", "Maintain", "Debug", "Test", "Computer Programs", "Programming", "Programmer",
        "Microsoft", "Microsoft Excel", "MS Excel", "Microsoft Office", "MS Office", "Software Development",
        "HTML", "Retention", "SQL", "Modeling", "Modelling", "Analytics", "Apache", "Apache Airflow",
        "Apache Impala", "Apache Drill", "Apache Hadoop", "Data", "Certification", "Data Collection",
        "Datasets", "Business Requirements", "Data Mining", "Data Science", "Visualization",
        "Technical Guidance", "Client Analytics", "Programming Skills", "SQL Server", "Computer Science",
        "Statistical Modeling", "Applied Data Science", "Hiring", "Technical", "Database", "Education",
        "R", "C", "C++", "C#", "Ruby", "Ruby on Rails", "Weka", "Matlab", "Django", "NetBeans",
        "IDE", "Stochastic", "Marketing", "Mining", "Mathematics", "Forecasts", "Statistics",
        "Programming", "Python", "Microsoft SQL Server", "NoSQL", "Hadoop", "Spark", "Java", "Algorithms",
        "Databases", "Numpy", "Pandas", "scikit-learn", "Clustering", "Classification", "Neural Networks",
        "TensorFlow", "PyTorch", "Theano", "Keras", "Pig", "AdaBoost", "Statistical Analysis",
        "Machine Learning", "Data Analysis", "Regression", "k-means", "Bayesian Estimation", "Random Forest",
        "Decision Tree", "Principal Component Analysis", "Gradient Descent", "AWS", "MacOS", "Linux",
        "SwiftUI", "iOS Development"
    ].map { Skill(name: $0) }
    
    @State private var showError = false
    
    @State private var searchText = ""
    @State private var selectedSkills = Set<Skill>()
    @State private var isDropdownOpen = false
    private var maxNumberOfSkills = 5
    
    @State private var hobbies = [Hobby]()
    @State private var newHobby = ""
    private var maxNumberOfHobbies = 5
    @State private var isAddingHobby = true
    @State private var navigateToQuestioner = false
    @State private var errorMessage = ""
    
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                
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
                    if hobbies.count < maxNumberOfHobbies{
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
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("Skills (\(selectedSkills.count)/\(maxNumberOfSkills)):")
                            .font(.system(size: 25))
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
                                .padding(.horizontal, 10)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                    }
                    .padding(.bottom, 4)
                    
                    if selectedSkills.count < maxNumberOfSkills {
                        
                        Button(action: { isDropdownOpen.toggle() }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(10)
                            
                        }
                    }
                    
                    if isDropdownOpen && selectedSkills.count < maxNumberOfSkills {
                        VStack {
                            // Search Bar
                            TextField("Search skills", text: $searchText)
                                .padding(8)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            
                            // Skills List
                            ScrollView {
                                VStack(alignment: .leading) {
                                    ForEach(filteredSkills, id: \.self) { skill in
                                        SkillRow(skill: skill, isSelected: selectedSkills.contains(skill)) {
                                            if !selectedSkills.contains(skill) && selectedSkills.count < 5 {
                                                selectedSkills.insert(skill)
                                                isDropdownOpen = false // close dropdown after selection
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxHeight: 200) // limit the dropdown height
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.top, 4)
                    }
                    Spacer()
                    
                    
                }
                HStack {
                    Spacer()
                    Button(action: {
                        if selectedSkills.count < 3 {
                            errorMessage = "Please select at least three skills to continue."
                            showError = true
                        } else {
                            isLoading = true
                            showError = false
                            navigateToQuestioner = true
                            uploadUserSkillsAndHobbies(selectedSkills: selectedSkills, hobbies: hobbies) { result in
                                switch result {
                                case .success:
                                    isLoading = false
                                    navigateToQuestioner = true
                                    print("Data uploaded successfully.")
                                case .failure(let error):
                                    isLoading = false
                                    errorMessage = "Failed to upload data: \(error)"
                                    showError = true
                                    print("Failed to upload data: \(error)")
                                }
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
            
            

            .navigationDestination(isPresented: $navigateToQuestioner) {
                EntryQuestionnaireView()
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
    
    // Filtered skills based on the search text
    private var filteredSkills: [Skill] {
        if searchText.isEmpty {
            return skills.filter { !selectedSkills.contains($0) } // filter out selected skills
        } else {
            return skills.filter { $0.name.lowercased().contains(searchText.lowercased()) && !selectedSkills.contains($0) }
        }
    }
    
    private func addHobby() {
        let trimmedHobby = newHobby.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedHobby.isEmpty, hobbies.count < maxNumberOfHobbies {
            hobbies.append(Hobby(name: trimmedHobby))
            newHobby = ""
        }
    }
    
    private func uploadUserSkillsAndHobbies(selectedSkills: Set<Skill>, hobbies: [Hobby], completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let userID = AuthManager.shared.getCurrentUser()?.uid else {
            
            return
        }
        
        let skillsData = selectedSkills.map { $0.name }
        let hobbiesData = hobbies.map { $0.name }
        
        

        
        let userData: [String: Any] = [
            "skills": skillsData,
            "hobbies": hobbiesData
        ]
        
        FirestoreManager.shared.addUser(uid: userID, data: userData) { result in
            switch result {
            case .success:
                print("User skills and hobbies successfully updated.")
                completion(.success(()))
            case .failure(let error):
                print("Error updating user skills and hobbies: \(error)")
                completion(.failure(error))
            }
        }
    }
}

struct SkillRow: View {
    let skill: Skill
    let isSelected: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Text(skill.name)
                    .foregroundColor(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 4)
        }
    }
}
struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView()
    }
}
