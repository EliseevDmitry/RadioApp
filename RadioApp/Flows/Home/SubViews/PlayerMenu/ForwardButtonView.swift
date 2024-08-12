//
//  ForwardButtonView.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 31.07.2024.
//

import SwiftUI

struct ForwardButtonView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var appManager: HomeViewModel
    //MARK: - BODY
    var body: some View {
        Button{
            appManager.nextTrackAudioStream()
        } label: {
            Image(.play)
                .resizable()
                .frame(width: 17, height: 17)
        }
        .frame(width: 48, height: 48)
        .background {
            PlayButtonShape()
                .fill(DS.Colors.turquoise)
        }
    }
    
}

//MARK: - PREVIEW
struct ForwardButtonView_Previews: PreviewProvider {
    static let previewAppManager = HomeViewModel()
    static var previews: some View {
        ForwardButtonView()
            .environmentObject(previewAppManager)
    }
}
