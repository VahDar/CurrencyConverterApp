//
//  NavigationBarView.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import SwiftUI

struct NavigationBarView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    let title: String
    var isBackButtonVisible: Bool
    var backAction: (() -> Void)?
    
    // MARK: - Content
    var body: some View {
        VStack {
            HStack {
                if isBackButtonVisible {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        backAction?()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                Spacer()
                Text(title)
                    .font(Font.custom("Montserrat", size: 17))
                    .fontWeight(.semibold)
                    .padding(.trailing, isBackButtonVisible ? 50 : 0)
                Spacer()
                
            }
            
            .padding(.bottom, 3)
            Divider()
                .background(Color(uiColor: .tabBarUnpressed))
                .frame(height: 1)
        }
    }
}

// MARK: - Preview
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(title: "test", isBackButtonVisible: true)
    }
}


