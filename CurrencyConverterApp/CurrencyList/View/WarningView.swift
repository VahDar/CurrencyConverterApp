//
//  WarningView.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 02.11.2023.
//

import SwiftUI
  

struct WarningView: View {
    //Properties
    var action: () -> Void
    
    var body: some View {
        VStack {
            Image("warning")
                .padding(.bottom, 20)
            Text("Something went wrong while fetching data. Please, try again")
                .font(.custom("Montserrat", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 45)
                .padding(.bottom, 30)
            Button("Retry") {
                action()
            }
            .frame(width: 200, height: 43)
            .foregroundColor(.white)
            .background(Color(uiColor: .retryButton))
            .cornerRadius(8)
        }
    }
}

#Preview {
    WarningView(action: {})
}
