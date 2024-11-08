//
//  EditProfileView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//


import SwiftUI
struct ProfileView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var profession: String = ""
    @State private var location: String = ""
    @State private var summary: String = ""
    @State private var skills: String = ""
    @State private var interests: String = ""
    
    @State private var cvUrl: URL?
    @State private var showDocumentPicker = false
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        Image(.defaultpp)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.top, 30)
                        
                        Text("Keep answering")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.gray)
                        
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
                                    .padding(.trailing, 20)
                                    .shadow(radius: 5)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 20) {
                                VStack(alignment: .leading) {
                                    Text("Name")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundStyle(.gray)
                                        .padding(.leading, 20)
                                    
                                    Text("Jules")
                                        .padding()
                                        .font(.system(size: 24, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 50)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Last name")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundStyle(.gray)
                                        .padding(.leading, 20)
                                    
                                    Text("Morillon")
                                        .padding()
                                        .font(.system(size: 24, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 50)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Industry")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundStyle(.gray)
                                        .padding(.leading, 20)
                                    
                                    Text("Software development")
                                        .padding()
                                        .font(.system(size: 24, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 50)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                        .multilineTextAlignment(.leading)
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
                        .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Spacer()
                            Text("My Profile")
                                .font(.headline)
                        }
                    }
                }
                .sheet(isPresented: $showDocumentPicker) {
                    DocumentPicker(cvUrl: $cvUrl)
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
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
