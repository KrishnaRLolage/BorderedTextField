//
//  ExampleApp.swift
//  BorderedTextField Example
//
//  Created by krishna.lolage
//

import SwiftUI
import BorderedTextField

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var notes = ""
    @State private var readOnlyText = "This is read-only"
    
    @State private var usernamePlaceholder = "Username"
    @State private var passwordPlaceholder = "Password"
    @State private var emailPlaceholder = "Email Address"
    @State private var notesPlaceholder = "Notes"
    @State private var readOnlyPlaceholder = "Read Only Field"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    headerView
                    
                    VStack(spacing: 20) {
                        // Basic text field
                        exampleSection(title: "Basic Text Field") {
                            BorderedTextField(
                                placeHolder: $usernamePlaceholder,
                                text: $username
                            )
                        }
                        
                        // Password field
                        exampleSection(title: "Password Field") {
                            BorderedTextField(
                                placeHolder: $passwordPlaceholder,
                                text: $password,
                                isSecureField: true
                            )
                        }
                        
                        // Custom colors
                        exampleSection(title: "Custom Colors") {
                            BorderedTextField(
                                placeHolder: $emailPlaceholder,
                                text: $email,
                                borderColor: .orange,
                                highlightColor: .purple
                            )
                        }
                        
                        // Read-only field
                        exampleSection(title: "Read-Only Field") {
                            BorderedTextField(
                                placeHolder: $readOnlyPlaceholder,
                                text: $readOnlyText,
                                isEditingEnabled: false,
                                borderColor: .gray.opacity(0.5)
                            )
                        }
                        
                        // Hidden placeholder
                        exampleSection(title: "Traditional Border") {
                            BorderedTextField(
                                placeHolder: $notesPlaceholder,
                                text: $notes,
                                showBorderPlaceHolder: false,
                                borderColor: .green,
                                highlightColor: .blue
                            )
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("BorderedTextField")
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("BorderedTextField")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("A beautiful SwiftUI text field component")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 20)
    }
    
    private func exampleSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            content()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
