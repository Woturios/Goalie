//
//  DonateView.swift
//  CashRefill
//
//  Created by Woturios on 30/06/2022.
//

import SwiftUI

struct DonateView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showMore: Bool = false
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .center) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                ScrollView {
                    Text("Support Goalie 💕")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 20) {
                        CryptoWalletView(currency: "Dogecoin", walletKey: "DogecoinWalletKey")
                        CryptoWalletView(currency: "Bitcoin", walletKey: "BitcoinWalletKey")
                        CryptoWalletView(currency: "Tezos", walletKey: "TezosWalletKey")
                        CryptoWalletView(currency: "BUSD", walletKey: "BUSDWalletKey")
                        CryptoWalletView(currency: "Dash", walletKey: "DashWalletKey")
                        CryptoWalletView(currency: "Alchemy Pay", walletKey: "AlchemyPayWalletKey")
                        CryptoWalletView(currency: "Ethereum", walletKey: "EthereumWalletKey")
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    
                    descriptionView
                    
                    Spacer()

                }
                .frame(maxWidth: 500)
            }
            .padding()
        }
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
            .preferredColorScheme(.light)
            .environmentObject(HomeViewModel())
        
        DonateView()
            .preferredColorScheme(.dark)
            .environmentObject(HomeViewModel())
        
//                CryptoWalletView(currency: "Dogecoin", wasCopied: true, walletKey: "DogecoinWalletKey")
//                    .preferredColorScheme(.light)
//                    .previewLayout(.sizeThatFits)
//
//                CryptoWalletView(currency: "Dogecoin", wasCopied: true, walletKey: "BitcoinWalletKey")
//                    .preferredColorScheme(.dark)
//                    .previewLayout(.sizeThatFits)
    }
}

extension DonateView {
    
    private var descriptionView: some View {
        VStack {
            Text("""
We are working hard, all the time to make Goalie better. 💪
📢 However we decided to make Goalie totally free and ad-free because we know how anoying it would be to use app like that. 🤑

If you would like to support ❤️ us you can send us some Cryptocurrency - tapp currency to copy our wallet adress to clipboard. 📋

We need funds to pay for Apple Development system - basically it allows us to make app avialable on App Store and further expences will grow along with app inprovements. 🧑‍💻

Thanks to any one who decided to support us 💕
""")
            .foregroundColor(showMore ? Color.theme.accent.opacity(0.9) : Color.theme.accent.opacity(0.5))
            .padding(.bottom, 25)
            
            Button {
                showMore.toggle()
            } label: {
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: showMore ? 180 : 0))
                    .font(.largeTitle)
                    .foregroundColor(Color.purple)
                    .animation(.easeInOut, value: showMore)
            }
            
        }
        .frame(height: showMore ? nil : 180)
        .padding()
        .cornerRadius(10)
        .animation(.spring(), value: showMore)

    }
}

struct CryptoWalletView: View {
    
    @State var currency: LocalizedStringKey
    @State var wasCopied: Bool = false
    @State var walletKey: String
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        Button {
            copyToClipboard()
        } label: {
            ZStack {
                Color.black.opacity(0)
                
                HStack {
                        Text(currency)
                        Spacer()
                        Image(systemName: wasCopied ? "doc.text.fill" : "doc")
                    }
                .font(.title2)
            }
        }
        .withPressableStyle()
    }
    
    func copyToClipboard() {
        pasteboard.string = self.walletKey
        self.wasCopied = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            wasCopied = false
        }
    }
}
