//
//  EmojiPickerView.swift
//  CashRefill
//
//  Created by Woturios on 24/07/2022.
//

import SwiftUI

struct EmojiPickerView: View {
    
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
        
    var body: some View {
        VStack {
            SheetTitleView(title: "Select emoji")
            ScrollView {
                SingleCategoryView(title: "Faces", emojis: faces)
                SingleCategoryView(title: "Fashion", emojis: fashion)
                SingleCategoryView(title: "Sports", emojis: sports)
                SingleCategoryView(title: "Hobbies", emojis: hobby)
                SingleCategoryView(title: "Traveling", emojis: travel)
                SingleCategoryView(title: "Objects", emojis: objects)
                SingleCategoryView(title: "Utilities", emojis: utilities)
                SingleCategoryView(title: "Animals", emojis: animals)
                SingleCategoryView(title: "Investing", emojis: investing)
                Spacer()
            }
        }
        .padding(.horizontal)
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
    let emojis: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 6, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(emojis, id: \.self) { emoji in
                        subView(emoji: emoji)
                    }
                } header: {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: vm.dataDisplayStyle ? .infinity : nil, alignment: .leading)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 40)
                        .background(vm.getAccentColor().brightness(0.5))
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct subView: View {
    
    @State var wasTapped: Bool = false
    let emoji: String
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Text(emoji)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(wasTapped ? vm.getAccentColor().opacity(0.5) : Color.clear)
            .cornerRadius(10)
            .onTapGesture {
                vm.currentEmoji = emoji
                wasTapped = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    wasTapped = false
                }
            }
            .animation(.easeInOut, value: wasTapped)
    }
}
