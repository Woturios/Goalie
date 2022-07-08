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
    let url: URL = URL(string: "https://paypal.me/jantonowicz?country.x=PL&locale.x=pl_PL")!
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .center) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        siteTitle
                        supportByCash
                        descriptionView
                        cryptocurrencies
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                        Spacer()
                    }
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
    }
}

extension DonateView {
    
    private var cryptocurrencies: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Cryptocurrencies")
                .font(.title)
                .fontWeight(.semibold)
            
            Divider()
            CryptoWalletView(currency: "Dogecoin", walletKey: "DogecoinWalletKey")
            CryptoWalletView(currency: "Bitcoin", walletKey: "BitcoinWalletKey")
            CryptoWalletView(currency: "Tezos", walletKey: "TezosWalletKey")
            CryptoWalletView(currency: "BUSD", walletKey: "BUSDWalletKey")
            CryptoWalletView(currency: "Dash", walletKey: "DashWalletKey")
            CryptoWalletView(currency: "Alchemy Pay", walletKey: "AlchemyPayWalletKey")
            CryptoWalletView(currency: "Ethereum", walletKey: "EthereumWalletKey")
        }

    }
    
    private var supportByCash: some View {
        HStack {
            Link(destination: url) {
                Text("PayPal")
                    .foregroundColor(Color.theme.accent)
                    .font(.title)
                    .frame(height: 100)
                    .frame(maxWidth:.infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            
            Text("Apple Pay")
                .foregroundColor(Color.gray)
                .font(.title)
                .frame(height: 100)
                .frame(maxWidth:.infinity)
                .background(Color.black)
                .border(Color.gray.opacity(0.5), width: 5)
                .cornerRadius(10)
        }
    }
    
    private var siteTitle: some View {
        Text("Support Goalie 💕")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading) {
            Text("Why is it worth?")
                .font(.title)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Divider()
            
            Text("""
We are working hard, all the time to make Goalie better. 💪
📢 However we decided to make Goalie totally free and ad-free because we know how anoying it would be to use app like that. 🤑

If you would like to support ❤️ us you can send us some Cryptocurrency - tap currency to copy our wallet adress to clipboard. 📋

We need funds to pay for Apple Development system - basically it allows us to make app avialable on App Store and further expences will grow along with app inprovements. 🧑‍💻

Thanks to any one who decided to support us 💕
""")
            .lineLimit(showMore ? nil : 3)
            .foregroundColor(Color.theme.secondary)
            .padding(.bottom, 25)
            
            Button {
                withAnimation(.easeInOut) {
                    showMore.toggle()
                }
            } label: {
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: showMore ? 180 : 0))
                    .font(.largeTitle)
                    .foregroundColor(Color.purple)
                    .animation(.easeInOut, value: showMore)
                    .frame(maxWidth: .infinity)
            }
            
        }
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
