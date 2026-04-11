//
//  ContentView.swift
//  Calculator
//
//  Created by Prabhnoor Kaur on 12/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var income = ""
    @State private var taxRate = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Tax Calculator")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 60)
                .padding(.bottom, 48)

            Text("Income (₹)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "606770"))
                .padding(.bottom, 8)

            TextField("", text: $income)
                .keyboardType(.decimalPad)
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(6)
                .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 1)
                .padding(.bottom, 28)

            Text("Tax Rate (%)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "606770"))
                .padding(.bottom, 8)

            TextField("", text: $taxRate)
                .keyboardType(.decimalPad)
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(6)
                .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 1)
                .padding(.bottom, 40)

            Button("Calculate Tax") {}
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color(hex: "0A7CFF"))
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .cornerRadius(6)
                .padding(.bottom, 48)

            VStack(alignment: .leading, spacing: 12) {
                Text("Calculation Result")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "1C1E21"))

                Text("Tax Amount: ₹ 0.00")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "D93025"))

                Text("Final Income: ₹ 0.00")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "1E8E3E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "F0F2F5"))
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
