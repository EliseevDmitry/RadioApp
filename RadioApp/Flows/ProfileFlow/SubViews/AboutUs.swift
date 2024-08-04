//
//  AboutUs.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

// MARK: - AboutUs View
struct AboutUs: View {
    // MARK: - Properties
    let teamLead = (
        name: Resources.Text.eliseev,
        git: Resources.Text.eliseevGit,
        avatar: UIImage(named: Resources.Image.eliseev)!
    )
    
    let developers = [
        (
            name: Resources.Text.gindulin,
            git: Resources.Text.gindulinGit,
            avatar: UIImage(named: Resources.Image.gindulin)!
        ),
        (
            name: Resources.Text.keller,
            git: Resources.Text.kellerGit,
            avatar: UIImage(named: Resources.Image.keller)!
        ),
        (
            name: Resources.Text.kukarskiy,
            git: Resources.Text.kukarskiyGit,
            avatar: UIImage(named: Resources.Image.kukarskiy)!
        )
    ]
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let avatarSize: CGFloat = 80
        static let verticalPadding: CGFloat = 10
        static let horizontalPadding: CGFloat = 10
        static let nameFontSize: CGFloat = 20
        static let gitFontSize: CGFloat = 12
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
                .ignoresSafeArea()
            
            List {
                Section(header: Text(Resources.Text.teamLead)
                    .font(.title)
                    .foregroundColor(.white)) {
                        AboutUsCell(
                            name: teamLead.name,
                            gitURL: teamLead.git,
                            avatar: teamLead.avatar
                        )
                        .padding(.vertical, Drawing.verticalPadding)
                    }
                
                Section(header: Text(Resources.Text.developers)
                    .font(.title)
                    .foregroundColor(.white)) {
                        ForEach(developers, id: \.name) { developer in
                            AboutUsCell(
                                name: developer.name,
                                gitURL: developer.git,
                                avatar: developer.avatar
                            )
                            
                        }
                    }
            }
            .listStyle(PlainListStyle())
            .listRowInsets((EdgeInsets()) )
            .background(Color.clear)
            
        }
        .navigationTitle(Resources.Text.aboutUs.capitalized)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AboutUs()
}
