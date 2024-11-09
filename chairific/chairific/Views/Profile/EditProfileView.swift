//
//  EditProfileView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cvUrl: URL?
    @State private var showDocumentPicker = false
    let isEmployee: Bool
    @State private var isEditing = false
    @State private var showAlert = false

    @AppStorage("isSignedIn") private var isSignedIn: Bool = true
    @AppStorage("isUserAnswers") private var isUserAnswers: Bool = true
    @State private var navigateToQuestionnaire = false  // State to manage navigation
    @ObservedObject var userManager = UserManager.shared
    @ObservedObject var companyManager = CompanyManager.shared
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        
                    }) {
                        HStack {
//                            Image(systemName: "chevron.left")
//                                .font(.headline)
//                                .foregroundColor(.gray)
                            Text("Your throne")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        isEditing.toggle()
                        if isEditing{
                            // update infos
                        }
                    }) {
                        Image(systemName: isEditing ? "checkmark" : "square.and.pencil")
                            .foregroundColor(.gray)
                            .font(.system(size: 24, weight: .bold))
                            .padding()
                    }
                    
                }
                .padding(.horizontal)
                
                Image(.mainchair)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .padding(.top, 30)
                ScrollView {
                    Text("Keep answering")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    ProgressView(value: Double(UserManager.shared.usersResponses.count) / 44.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
                    HStack(spacing: 120) {
                        Text("0")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        Text("22")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        Text("44+")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    NavigationLink(destination: EntryQuestionnaireView(firstLogin: false), isActive: $navigateToQuestionnaire) {
                        
                        Button(action: {
                            navigateToQuestionnaire = true

                            let lastQuestion = findLatestNonZeroID(from: UserManager.shared.usersResponses)
                            
                        }) {
                            HStack {
                                Spacer()
                                Text("Answer")
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(width: 200, height: 50)
                                    .background(.lightorange)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                    if isEmployee {
                        EmployeeProfileContentView(showDocumentPicker: $showDocumentPicker, isEditing: $isEditing)
                    } else {
                        NonEmployeeContentView(showDocumentPicker: $showDocumentPicker, isEditing: $isEditing)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Account Settings")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.gray)
                            .padding(.leading, 20)
            
                        Button(action: {
                            AuthManager.shared.signOutUser() { result in
                                switch result {
                                case .success:
                                    // TO UPDATE
                                    isSignedIn = false
                                    isUserAnswers = false
                                case .failure:
                                    print("Fail to sign out")
                                }
                            }
                        }) {
                            HStack {

                                Text("Log out")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2))
                        }
                        .padding(.horizontal)
                        Button(action: {
                            showAlert = true
                        }) {
                            HStack {

                                Text("Delete Account")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 15)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("This action will delete your account and cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            Task {
                                do {
                                    try await deleteAccount()
                                    isSignedIn = false
                                    isUserAnswers = false
                                } catch {
                                    print(error)
                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 1)

            }
            
            .background(Color("backgroundColor"))
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(cvUrl: $cvUrl)
        }

        
    }
    
    func findLatestNonZeroID(from array: [String: Int]) -> String {
        // Sort the array by keys in descending order to find the latest ID
        let sortedKeys = array.keys.sorted { $0 > $1 }
        
        for key in sortedKeys {
            if let value = array[key], value != 0 {
                return key
            }
        }
        
        return "q1"
    }
    
    func deleteAccount() async throws{
        guard currentUserId != "" else {
            throw URLError(.badURL)
        }
        
        do {
//            try await FirestoreManager.shared.deleteUser(uid: user.uid)
            
            try await AuthManager.shared.deleteAccount()
            
            UserDefaults.standard.set(false, forKey: "isSignedIn")
            
            print("User account and document deleted successfully.")
            
        } catch {
        
            print("Failed to delete user account: \(error.localizedDescription)")
            throw error
        }
        
    }
    
}


struct EmployeeProfileContentView: View{
    @Binding var showDocumentPicker: Bool
    
    @Binding var isEditing: Bool
    
    @ObservedObject var userManager = UserManager.shared

    @State private var EmployeeName: String = (UserManager.shared.userFirstName ?? "User")
    @State private var EmployeeLastName: String = (UserManager.shared.userSecondName ?? "User")
    @State private var Employeeindustry: String = "Software development"
    
    
    var body: some View {
//        NavigationView{
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.gray)
                            .padding(.leading, 20)
                        
                        if isEditing {
                            TextField("Name", text: $EmployeeName)
                                .padding()
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        } else {
                            Text(UserManager.shared.userFirstName ?? "UserFirstName")
                                .padding()
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(Color("FigmaGrey"))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Last name")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.gray)
                            .padding(.leading, 20)
                        
                        if isEditing {
                            TextField("LastName", text: $EmployeeLastName)
                                .padding()
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        } else {
                            Text(userManager.userSecondName ?? "UserSecondName")
                                .padding()
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(Color("FigmaGrey"))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    //                VStack(alignment: .leading) {
                    //                    Text("Industry")
                    //                        .font(.system(size: 24, weight: .semibold))
                    //                        .foregroundStyle(.gray)
                    //                        .padding(.leading, 20)
                    //
                    //                    if isEditing {
                    //                        TextField("Industry", text: $Employeeindustry)
                    //                            .padding()
                    //                            .font(.system(size: 24, weight: .semibold))
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //                            .frame(height: 50)
                    //                            .background(Color(.systemGray5))
                    //                            .cornerRadius(10)
                    //                            .padding(.horizontal, 20)
                    //                    } else {
                    //                        Text(Employeeindustry)
                    //                            .padding()
                    //                            .font(.system(size: 24, weight: .semibold))
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //                            .frame(height: 50)
                    //                            .background(Color("FigmaGrey"))
                    //                            .cornerRadius(10)
                    //                            .padding(.horizontal, 20)
                    //                    }
                    //                }
                }
                VStack(alignment: .leading) {
                    Text("CV")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    Button(action: {
                        showDocumentPicker = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            Text("Upload CV")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2))
                    }
                    .padding(.horizontal)
                }
            }
//        }
    }
}

struct NonEmployeeContentView: View{
    @Binding var showDocumentPicker: Bool
    @State private var openChairs: [String] = []
    @State private var companyName = (CompanyManager.shared.companyName ?? "Mamaqat")
    @State private var industry = (CompanyManager.shared.companyIndustry ?? "entertainment")
//    @State private var website = "mamaqat.com"
    @Binding var isEditing: Bool
    @State private var addNewPosition: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Open Chairs")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    
                    ForEach(openChairs, id: \.self) { position in
                            HStack {
                                Text(position)
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                                    .padding()
                                    
                                
                                Spacer()
                                
                                Button(action: {}
                                ){
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.trailing, 20)
                                }
                            }
                            .background(Color(.white).cornerRadius(20))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .cornerRadius(20)
                        }
                    NavigationLink(destination: CreatePositionView(isFirstPositions: false), isActive: $addNewPosition) {
                        Button(action: {
                            addNewPosition = true
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 5)
                    }
                    }
                }
            
                
                VStack(alignment: .leading) {
                    Text("Company name")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    
                    if isEditing {
                        TextField("Company Name", text: $companyName)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    } else {
                        Text(companyName)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color("FigmaGrey"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Industry")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    
                    if isEditing {
                        TextField("Industry", text: $industry)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    } else {
                        Text(industry)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color("FigmaGrey"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
//                VStack(alignment: .leading) {
//                    Text("Website")
//                        .font(.system(size: 24, weight: .semibold))
//                        .foregroundStyle(.gray)
//                        .padding(.leading, 20)
//                    
//                    if isEditing {
//                        TextField("Website", text: $website)
//                            .padding()
//                            .font(.system(size: 24, weight: .semibold))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .frame(height: 50)
//                            .background(Color(.systemGray5))
//                            .cornerRadius(10)
//                            .padding(.horizontal, 20)
//                    } else {
//                        Text(website)
//                            .padding()
//                            .font(.system(size: 24, weight: .semibold))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .frame(height: 50)
//                            .background(Color("FigmaGrey"))
//                            .cornerRadius(10)
//                            .padding(.horizontal, 20)
//                    }
//                }
            }
        
        .onAppear {
                fetchOpenChairs()
            }
        }
        
    private func fetchOpenChairs() {
        FirestoreManager.shared.fetchPositions(forCompanyId: companyName) { result in
            switch result {
            case .success(let positionsDict):
                openChairs = positionsDict.compactMap { position in
                    position["position"] as? String
                }
            case .failure(let error):
                print("Failed to fetch positions: \(error.localizedDescription)")
            }
        }
    }

    }
    

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var cvUrl: URL?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.pdf", "public.text"], in: .import)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.cvUrl = url
            }
        }
    }
}



#Preview {
    EditProfileView(isEmployee: true)
}




