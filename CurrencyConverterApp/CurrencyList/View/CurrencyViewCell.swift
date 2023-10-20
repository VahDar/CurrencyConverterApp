//
//  CurrencyViewCell.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import SwiftUI

struct CurrencyCellView: View {
    let imageAndName: String
    let currencyName: String
    let amount: Double
    let selectedCurrency: String
    var amountString: Text {
        return formattedAmountText(amount: amount)
    }
    var body: some View {
        VStack {
            HStack {
                Image(imageAndName)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading, 9)
                Text(imageAndName)
                    .font(.custom("Inter-Medium", size: 14))
                    .padding(.leading, 3)
                Text(currencyName)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color.gray)
                    .padding(.leading, 1)
                Spacer()
                amountString
                Text(selectedCurrency)
                    .font(.custom("Inter-Medium", size: 14))
                    .padding(.trailing, 9)
            }
            .padding(.top, 8)
            Divider()
                .background(Color.gray)
                .frame(height: 1)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
func formattedAmountText(amount: Double) -> Text {
        let formattedAmount = String(format: "%.2f", amount)
        let components = formattedAmount.components(separatedBy: ".")
        guard components.count == 2 else {
            return Text(formattedAmount)
        }
        
        let wholePart = components[0]
        let decimalPart = components[1]
        let wholePartText = Text(wholePart)
            .font(.custom("Inter-Medium", size: 14))
            .foregroundColor(.black)
        let decimalPartText = Text(decimalPart)
        .font(.custom("Inter-Medium", size: 14))
            .foregroundColor(.gray)
        
        return wholePartText + Text(".") + decimalPartText
            
    }
    
}

struct CurrencyCellView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCellView(imageAndName: "USD", currencyName: "American Dollar", amount: 250, selectedCurrency: "USD")
    }
}

