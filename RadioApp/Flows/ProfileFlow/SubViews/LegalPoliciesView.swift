//
//  LegalPoliciesView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 28.07.2024.
//

import SwiftUI

struct LegalPoliciesView: View {
    var body: some View {
        ZStack {
            DS.Colors.darkBlue
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Tearms")
                        .font(
                            .custom(
                                .sfBold,
                                size: 18
                            )
                        )
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                        .padding(.top, 6)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                    
                    Text("Changes to the Service and/or Terms:")
                        .font(
                            .custom(
                                .sfBold,
                                size: 16
                            )
                        )
                        .padding(.top, 20)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                        .padding(.top, 6)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                    
                    Spacer()
                }
                .font(
                    .custom(
                        .sfBold,
                        size: 16
                    )
                )
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .navigationTitle(Resources.Text.legalAndPolicies)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackBarButton()
            }
        }
    }
}


#Preview {
    LegalPoliciesView()
}
