//
//  EmojiPickerView.swift
//  CashRefill
//
//  Created by Woturios on 24/07/2022.
//

import SwiftUI

struct EmojiPickerView: View {
    
    // OLD EMOJI
    /*
    private let fashion: [String] = [
        "💍", "👜", "👘", "👢", "🕶", "👖", "👠", "👟", "🧥", "🧢", "👗",
    ]
    
    private let animals: [String] = [
        "🐶", "🐰", "🐥", "🐣", "🐴", "🦄", "🦕", "🦖", "🦎", "🐢", "🐍", "🐑", "🐈",
    ]
    
    private let sports: [String] = [
        "🛹", "⚽️", "🏀", "🏈", "🎾",  "🎱", "🏓", "🏹", "⛳️", "🥊", "🥋", "🤿", "🛼", "⛸", "⛷", "🏂", "🪂", "🏋️‍♀️", "🏄‍♀️", "🚲", "🛴"
    ]
    
    private let hobby: [String] = [
        "🎬", "🎤", "🎹", "🥁", "🎨", "🎷", "🎸",
    ]
    
    private let utilities: [String] = [
        "🚗", "🚙", "🏍", "🛞", "🛵", "🚘", "✈️", "🛩", "🚁", "🛳", "🏠", "🏡", "🏘", "🏨",
    ]
    
    private let objects: [String] = [
        "🎧", "🎮", "🏎", "🚀", "⌚️", "📱", "💻", "⌨️", "🖥", "🖱", "💽", "📷", "🎥", "📺", "💡", "🛢", "💸", "💵", "💴", "💶", "💳", "💎", "🛠", "⚱️", "🛏", "🛒", "🎁", "🖼", "🎉",
    ]
    
    private let travel: [String] = [
        "🗿", "🗽", "🏰", "🗼", "🎡", "🏟", "🎢", "🏖", "🏝", "🏜", "🌋", "🏔", "🗻", "🏕", "🛖", "🏛", "🕌", "🕍", "🛕", "🕋", "⛩", "🌉", "🌄", "🗾", "🛣", "🏞", "🏙", "🌌", "🌅", "🎇", "🎆", "🌇", "🌁",
    ]
    
    private let investing: [String] = [
        "📈", "📊", "🗃",
    ]
    
    private let faces: [String] = [
        "🥹", "☺️", "😍", "🙃", "😛", "🤪", "😎", "🥸", "🥺", "🤠", "😈", "😺",
    ]
     */
    
    @State var emojiSearchText: String = ""
        
    var body: some View {
        ZStack {
            Color.theme.reversed.ignoresSafeArea()
            
            VStack {
                SheetTitleView(title: "")
                TextField("Select emoji", text: $emojiSearchText)
                    .withDefaultTextFieldFormatting()
                ScrollView {
                    if emojiSearchText != "" {
                        SingleCategoryView(title: emojiSearchText, emojis: EmojiProvider.all().filter({ $0.description.contains(emojiSearchText.lowercased()) }))
                    } else {
                        SingleCategoryView(title: "Faces", emojis: EmojiProvider.all().filter({ $0.category == "faces" }))
                        SingleCategoryView(title: "Fashion", emojis: EmojiProvider.all().filter({ $0.category == "fashion" }))
                        SingleCategoryView(title: "Sports", emojis: EmojiProvider.all().filter({ $0.category == "sports" }))
                        SingleCategoryView(title: "Hobbies", emojis: EmojiProvider.all().filter({ $0.category == "hobby" }))
                        SingleCategoryView(title: "Traveling", emojis: EmojiProvider.all().filter({ $0.category == "travel" }))
                        SingleCategoryView(title: "Objects", emojis: EmojiProvider.all().filter({ $0.category == "objects" }))
                        SingleCategoryView(title: "Utilities", emojis: EmojiProvider.all().filter({ $0.category == "utilities" }))
                        SingleCategoryView(title: "Animals", emojis: EmojiProvider.all().filter({ $0.category == "animals" }))
                        SingleCategoryView(title: "Investing", emojis: EmojiProvider.all().filter({ $0.category == "investing" }))
                    }
                }
            }
            .padding(.horizontal)

        }
    }
}

struct EmojiPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerView()
//        SingleCategoryView(title: "Title", emojis: ["💍", "👜", "👘", "👢", "🕶", "👖", "👠", "👟", "🧥", "🧢", "👗"])
            .environmentObject(HomeViewModel())
    }
}

struct SingleCategoryView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    let title: String
    let emojis: [EmojiModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 6, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(emojis) { emoji in
                        subView(emoji: emoji)
                    }
                } header: {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: vm.dataDisplayStyle ? .infinity : nil, alignment: .leading)
                        .padding(.vertical)
                        .background(Color.theme.reversed)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct subView: View {
    
    @State var wasTapped: Bool = false
    let emoji: EmojiModel
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Text(emoji.emoji)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(wasTapped ? vm.getAccentColor().opacity(0.5) : Color.clear)
            .cornerRadius(10)
            .onTapGesture {
                vm.currentEmoji = emoji.emoji
                wasTapped = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    wasTapped = false
                }
            }
            .animation(.easeInOut, value: wasTapped)
    }
}
