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
    @State private var isEmployee = true
    @State private var isEditing = false
    
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                                .foregroundColor(.gray)
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
                
                Image(.defaultpp)
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
                    
                    ProgressView(value: 0.3)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .padding(.horizontal)
                        .padding(.horizontal)
                    
                    HStack(spacing: 120) {
                        Text("0")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        Text("50")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        Text("500+")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
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
                    .padding()
                    if isEmployee {
                        EmployeeProfileContentView(showDocumentPicker: $showDocumentPicker, isEditing: $isEditing)
                    } else {
                        NonEmployeeContentView(showDocumentPicker: $showDocumentPicker, isEditing: $isEditing)
                    }
                }
                Spacer()
            }
            .background(Color("backgroundColor"))
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(cvUrl: $cvUrl)
        }
        
    }
    
}


struct EmployeeProfileContentView: View{
    @Binding var showDocumentPicker: Bool
    
    @Binding var isEditing: Bool
    
    @State private var EmployeeName: String = (UserManager.shared.userFirstName ?? "User")
    @State private var EmployeeLastName: String = (UserManager.shared.userSecondName ?? "User")
    @State private var Employeeindustry: String = "Software development"
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(UserManager.shared.userFirstName ?? "User")
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
                        Text(EmployeeName)
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
                        Text(EmployeeLastName)
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
                        TextField("Industry", text: $Employeeindustry)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    } else {
                        Text(Employeeindustry)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color("FigmaGrey"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
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
    }
}

struct NonEmployeeContentView: View{
    @Binding var showDocumentPicker: Bool
    let openChairs = ["Software Development", "Market Researcher"]
    @State private var companyName = "Mamaqat"
    @State private var industry = "Entertainment"
    @State private var website = "mamaqat.com"
    @Binding var isEditing: Bool
    
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
                        
                        Button(action: {
                            
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
                VStack(alignment: .leading) {
                    Text("Website")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.leading, 20)
                    
                    if isEditing {
                        TextField("Website", text: $website)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    } else {
                        Text(website)
                            .padding()
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(Color("FigmaGrey"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
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
    EditProfileView()
}




