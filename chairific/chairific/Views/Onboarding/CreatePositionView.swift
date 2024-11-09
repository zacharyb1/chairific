//
//  CreatePositionView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct CreatePositionView: View {
    
    // Properties for position details
    let isFirstPositions: Bool
    @State private var positionName = ""
    @State private var positionDescription = ""

    // Properties for skills section
    @State private var skills: [String] = [
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
    ]
    
    @State private var selectedSkills = Set<String>()
    @State private var searchText = ""
    var maxNumberOfSkills = 3
    
    // Navigation
    @State private var navigateToQuestionnaire: Bool = false
    @State private var navigateToPositionsList: Bool = false

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
                                Text("+ \(skill)")
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
                }
            }
            .navigationDestination(isPresented: $navigateToPositionsList) {
                CompanyQuestionnaireView()
            }
            .navigationDestination(isPresented: $navigateToQuestionnaire) {
                PositionsListView()
            }
            .navigationBarBackButtonHidden(isFirstPositions)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: createPosition) {
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
    
    private var filteredSkills: [String] {
        if searchText.isEmpty {
            return skills.filter { !selectedSkills.contains($0) }
        } else {
            return skills.filter { $0.lowercased().contains(searchText.lowercased()) && !selectedSkills.contains($0) }
        }
    }
    
    private func createPosition() {
        guard !selectedSkills.isEmpty else { return }
        
        let positionData: [String: Any] = [
            "companyId": CompanyManager.shared.companyName!,
            "position": positionName,
            "description": positionDescription,
            "skills": selectedSkills,
        ]
        
        FirestoreManager.shared.addPosition(data: positionData) {
            
        }
    }
}


#Preview {
    CreatePositionView(isFirstPositions: false)
}
