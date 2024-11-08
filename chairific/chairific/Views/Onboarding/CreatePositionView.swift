//
//  CreatePositionView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//
import SwiftUI

struct CreatePositionView: View {
    // Properties for position details
    @State private var positionName = ""
    @State private var positionDescription = ""
    @State private var newCulture = ""
    @State private var culture = [Hobby]()
    @State private var benefits = ""
    @State private var isAddingCulture = false

    // Properties for skills section
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
    
    @State private var selectedSkills = Set<Skill>()
    @State private var searchText = ""
    @State private var isDropdownOpen = false
    private var maxNumberOfSkills = 5

    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Position Details
                    Group {
                        Text("Chair setup")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding(.top)
                        
                        Text("Name of the position")
                            .foregroundColor(.gray)
                        TextField("", text: $positionName)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        
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
                        
                        if isDropdownOpen {
                            VStack {
                                TextField("Search skills", text: $searchText)
                                    .padding(8)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                
                                ScrollView {
                                    VStack(alignment: .leading) {
                                        ForEach(filteredSkills, id: \.self) { skill in
                                            SkillRow(skill: skill, isSelected: selectedSkills.contains(skill)) {
                                                if !selectedSkills.contains(skill) && selectedSkills.count < maxNumberOfSkills {
                                                    selectedSkills.insert(skill)
                                                    isDropdownOpen = false // close dropdown after selection
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(maxHeight: 200)
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.top, 4)
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

                    // Benefits Section
                    VStack(alignment: .leading) {
                        Text("Benefits")
                            .foregroundColor(.gray)
                        TextField("", text: $benefits)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 25)
                
                // Continue Button
                
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Continue")
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
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

    private var filteredSkills: [Skill] {
        if searchText.isEmpty {
            return skills.filter { !selectedSkills.contains($0) }
        } else {
            return skills.filter { $0.name.lowercased().contains(searchText.lowercased()) && !selectedSkills.contains($0) }
        }
    }
}


#Preview {
    CreatePositionView()
}
