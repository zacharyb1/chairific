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
    @State private var isDropdownOpen = false
    @Environment(\.dismiss) var dismiss

    // Properties for skills section
    @State private var skills: [String] = [
        "Develop", "Maintain", "Analyze", "Evaluate", "Project Management", "Data Analysis", "Reporting",
        "Research", "Team Collaboration", "Client Management", "Microsoft Office", "Excel", "Documentation",
        "Communication", "Strategy", "Problem Solving", "Creativity", "Innovation", "Process Improvement",
        "Leadership", "Critical Thinking", "Negotiation", "Public Speaking", "Time Management", "Presentation Skills",
        "Sales", "Marketing", "Customer Service", "Client Relations", "Social Media", "Networking",
        "Writing", "Editing", "Content Creation", "Design", "Branding", "Creativity", "SEO", "Market Research",
        "Financial Analysis", "Budgeting", "Forecasting", "Risk Management", "Data Entry", "Compliance",
        "Policy Development", "Operations", "Supply Chain", "Inventory Management", "Quality Assurance",
        "Training", "Mentoring", "Instruction", "Education", "Scheduling", "Documentation", "Process Mapping",
        "Technical Writing", "Health & Safety", "Project Planning", "Resource Management", "Human Resources",
        "Conflict Resolution", "Employee Relations", "Hiring", "Onboarding", "Customer Satisfaction", "Feedback",
        "Strategic Planning", "Decision Making", "Goal Setting", "Quality Control", "Legal Compliance",
        "Auditing", "Financial Reporting", "Taxation", "Customer Experience", "Event Planning", "Public Relations",
        "Survey Design", "Data Collection", "Organizational Skills", "Product Development", "Trend Analysis",
        "Data Visualization", "Presentation", "Documentation", "Report Writing", "Negotiation", "Process Design",
        "Digital Marketing", "Advertising", "Campaign Management", "CRM", "Supply Chain Management",
        "Procurement", "Vendor Management", "Scheduling", "Project Coordination", "Stakeholder Management",
        "Proposal Writing", "Policy Analysis", "Customer Engagement", "Relationship Building", "Brand Strategy",
        "Corporate Social Responsibility", "Environmental Awareness", "Sustainability", "Change Management",
        "Risk Assessment", "Cultural Competence", "Diversity & Inclusion", "Employee Development",
        "Business Intelligence", "Analytics", "KPI Tracking", "Data Interpretation", "Market Analysis",
        "Forecasting", "Investment Analysis", "Budget Planning", "Resource Allocation", "Cross-Functional Teamwork",
        "Technical Support", "Client Training", "Process Optimization", "Workflow Improvement", "Team Building",
        "Employee Coaching", "Industry Knowledge", "Ethics", "Customer Insights", "Behavioral Analysis",
        "Innovation Management", "Project Execution", "Event Management", "Strategic Marketing",
        "Brand Management", "Learning & Development", "Customer Loyalty", "Client Services", "Product Lifecycle",
        "Business Strategy", "Value Proposition", "Operational Efficiency", "Process Innovation", "Technology Adoption",
        "Goal Alignment", "Talent Management", "Financial Strategy", "Community Engagement", "Resource Development"
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
                        
                        if selectedSkills.count < maxNumberOfSkills && isDropdownOpen{

                            
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
            }
            .navigationDestination(isPresented: $navigateToPositionsList) {
                // TO DO
                PositionsListView()
            }
            .navigationDestination(isPresented: $navigateToQuestionnaire) {
                CompanyQuestionnaireView(firstLogin: true)
            }
            .padding(.horizontal, 25)
            .navigationBarBackButtonHidden(isFirstPositions)


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
            "skills": Array(selectedSkills),
        ]
        
        FirestoreManager.shared.addPosition(data: positionData) { result in
            switch result {
            case .success():
                print("Successfully created new position")
                if isFirstPositions {
                    navigateToQuestionnaire = true
                } else {
                    dismiss()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


#Preview {
    CreatePositionView(isFirstPositions: false)
}
