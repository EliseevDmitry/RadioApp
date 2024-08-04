//
//  AboutUs.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 31.07.2024.
//

import SwiftUI

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
                    .foregroundStyle(.white)) {
                    HStack {
                        AvatarInCyrcleView(avatar: teamLead.avatar)
                            .frame(width: Drawing.avatarSize)
                        VStack(alignment: .leading) {
                            Text(teamLead.name)
                                .foregroundStyle(.white)
                                .font(.custom(DS.Fonts.sfBold, size: Drawing.nameFontSize))
                                .padding(.leading, Drawing.horizontalPadding)
                            Link(teamLead.git, destination: URL(string: teamLead.git)!)
                                .foregroundStyle(DS.Colors.blueNeon)
                                .font(.custom(DS.Fonts.sfBold, size: Drawing.gitFontSize))
                                .padding(.leading, Drawing.horizontalPadding)
                        }
                    }
                    .padding(.vertical, Drawing.verticalPadding)
                }
                
                Section(header: Text(Resources.Text.developers)
                    .font(.title)
                    .foregroundStyle(.white)) {
                    ForEach(developers, id: \.name) { developer in
                        HStack {
                            AvatarInCyrcleView(avatar: developer.avatar)
                                .frame(width: Drawing.avatarSize)
                            VStack(alignment: .leading) {
                                Text(developer.name)
                                    .foregroundStyle(.white)
                                    .font(.custom(DS.Fonts.sfBold, size: Drawing.nameFontSize))
                                    .padding(.leading, Drawing.horizontalPadding)
                                Link(developer.git, destination: URL(string: developer.git)!)
                                    .foregroundStyle(DS.Colors.blueNeon)
                                    .font(.custom(DS.Fonts.sfBold, size: Drawing.gitFontSize))
                                    .padding(.leading, Drawing.horizontalPadding)
                            }
                        }
                        .padding(.vertical, Drawing.verticalPadding)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
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
