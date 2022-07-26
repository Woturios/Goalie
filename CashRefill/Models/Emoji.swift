//
//  Emoji.swift
//  CashRefill
//
//  Created by Woturios on 25/07/2022.
//

import Foundation
import SwiftUI

struct EmojiModel: Identifiable {
    let id = UUID()
    let emoji: String
    let description: String
    let category: String
}

public struct EmojiProvider {
    static func all() -> [EmojiModel] {
        return [
            // MARK: FASHION
            EmojiModel(emoji: "💍", description: "ring, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👜", description: "bag, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👘", description: "kimono, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "🎩", description: "hat, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👢", description: "shoes, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "🕶", description: "sunglasses, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👖", description: "jeans trousers, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👠", description: "shoes high heels, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👟", description: "shoes trainers, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "🧥", description: "coat, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "🧢", description: "cap, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👗", description: "dress, fashion, clothes", category: "fashion"),
            EmojiModel(emoji: "👓", description: "glasses, fashion, clothes", category: "fashion"),
            
            // MARK: Sports
            EmojiModel(emoji: "🛹", description: "skateboard, sports", category: "sports"),
            EmojiModel(emoji: "⚽️", description: "football socker ball, sports", category: "sports"),
            EmojiModel(emoji: "🏀", description: "basketball ball, sports", category: "sports"),
            EmojiModel(emoji: "🏈", description: "rugby football ball, sports", category: "sports"),
            EmojiModel(emoji: "🎾", description: "tennis ball, sports", category: "sports"),
            EmojiModel(emoji: "🎱", description: "ball, sports", category: "sports"),
            EmojiModel(emoji: "🏓", description: " table tennis ping pong, sports", category: "sports"),
            EmojiModel(emoji: "🏹", description: "archery arrow bow, sports", category: "sports"),
            EmojiModel(emoji: "⛳️", description: "golf, sports", category: "sports"),
            EmojiModel(emoji: "🥊", description: "boxing, sports", category: "sports"),
            EmojiModel(emoji: "🥋", description: "kimono karate, sports", category: "sports"),
            EmojiModel(emoji: "🤿", description: "diving mask, sports", category: "sports"),
            EmojiModel(emoji: "🛼", description: "roller skate, sports", category: "sports"),
            EmojiModel(emoji: "⛸", description: "ice skate, sports", category: "sports"),
            EmojiModel(emoji: "⛷", description: "ski winter, sports", category: "sports"),
            EmojiModel(emoji: "🏂", description: "snowboarding winter, sports", category: "sports"),
            EmojiModel(emoji: "🪂", description: "parachute sky jumping, sports", category: "sports"),
            EmojiModel(emoji: "🏋️‍♀️", description: "workout dumbbells weights, sports", category: "sports"),
            EmojiModel(emoji: "🏄‍♀️", description: "surfing, sports", category: "sports"),
            EmojiModel(emoji: "🚲", description: "bike, sports", category: "sports"),
            EmojiModel(emoji: "🛴", description: "scooter, sports", category: "sports"),
            
            // MARK: FACES
            EmojiModel(emoji: "🥹", description: "holding tears face smiley, faces", category: "faces"),
            EmojiModel(emoji: "☺️", description: "smiling face, faces", category: "faces"),
            EmojiModel(emoji: "😍", description: "love face hearth, faces", category: "faces"),
            EmojiModel(emoji: "🙃", description: "smiling face upsitedown, faces", category: "faces"),
            EmojiModel(emoji: "😛", description: "smiling face with tongue, faces", category: "faces"),
            EmojiModel(emoji: "🤪", description: "crazy drunk smiling face tongue, faces", category: "faces"),
            EmojiModel(emoji: "😎", description: "smiling face in sunglasses, faces", category: "faces"),
            EmojiModel(emoji: "🥸", description: "face in mask mustache incognito, faces", category: "faces"),
            EmojiModel(emoji: "🥺", description: "pleading face, faces", category: "faces"),
            EmojiModel(emoji: "🤠", description: "smiling face in cowboy hat, faces", category: "faces"),
            EmojiModel(emoji: "😈", description: "smiling devil face, faces", category: "faces"),
            EmojiModel(emoji: "😺", description: "smiling cat face, faces", category: "faces"),
            
            // MARK: HOBBIES
            EmojiModel(emoji: "🎬", description: "movie, filming hobby", category: "hobby"),
            EmojiModel(emoji: "🎤", description: "microphone, singing hobby", category: "hobby"),
            EmojiModel(emoji: "🎹", description: "piano, playing hobby", category: "hobby"),
            EmojiModel(emoji: "🥁", description: "drums, hobby", category: "hobby"),
            EmojiModel(emoji: "🎨", description: "painting, hobby", category: "hobby"),
            EmojiModel(emoji: "🎷", description: "saxophone, hobby", category: "hobby"),
            EmojiModel(emoji: "🎸", description: "electronic, guitar hobby", category: "hobby"),
            
            // MARK: TRAVELING
            EmojiModel(emoji: "🗿", description: "Easter Island, travel", category: "travel"),
            EmojiModel(emoji: "🗽", description: "New York Statue of liberty, travel", category: "travel"),
            EmojiModel(emoji: "🏰", description: "castle, travel", category: "travel"),
            EmojiModel(emoji: "🗼", description: "Tokyo Tower, travel", category: "travel"),
            EmojiModel(emoji: "🎡", description: "ferrris wheel, travel", category: "travel"),
            EmojiModel(emoji: "🏟", description: "Rome Italy Coloseum, travel", category: "travel"),
            EmojiModel(emoji: "🎢", description: "Roller cosaster, travel", category: "travel"),
            EmojiModel(emoji: "🏖", description: "beach seashore, travel", category: "travel"),
            EmojiModel(emoji: "🏝", description: "island seashore, travel", category: "travel"),
            EmojiModel(emoji: "🏜", description: "desert, travel", category: "travel"),
            EmojiModel(emoji: "🌋", description: "volcano isle, travel", category: "travel"),
            EmojiModel(emoji: "🏔", description: "mountain snow, travel", category: "travel"),
            EmojiModel(emoji: "🗻", description: "mount fuji, travel", category: "travel"),
            EmojiModel(emoji: "🏕", description: "camping tent in the forest, travel", category: "travel"),
            EmojiModel(emoji: "🛖", description: "hut, travel", category: "travel"),
            EmojiModel(emoji: "🏛", description: "greece temple athens pantheon, travel", category: "travel"),
            EmojiModel(emoji: "🕌", description: "mosque, travel", category: "travel"),
            EmojiModel(emoji: "🕍", description: "church synagogue, travel", category: "travel"),
            EmojiModel(emoji: "🛕", description: "hindu temple, travel", category: "travel"),
            EmojiModel(emoji: "🕋", description: "kabba muslim, travel", category: "travel"),
            EmojiModel(emoji: "⛩", description: "japan tokyo, travel", category: "travel"),
            EmojiModel(emoji: "🌉", description: "bridge san francisco california, travel", category: "travel"),
            EmojiModel(emoji: "🗾", description: "silhouette of japan, travel", category: "travel"),
            EmojiModel(emoji: "🛣", description: "motorway, travel", category: "travel"),
            EmojiModel(emoji: "🏞", description: "national park yosemite yellowstone grand canion, travel", category: "travel"),
            EmojiModel(emoji: "🏙", description: "city day, travel", category: "travel"),
            EmojiModel(emoji: "🌌", description: "milky way stars space, travel", category: "travel"),
            EmojiModel(emoji: "🌅", description: "sunset sunrise sea, travel", category: "travel"),
            EmojiModel(emoji: "🎇", description: "fireworks, travel", category: "travel"),
            EmojiModel(emoji: "🎆", description: "fireworks, travel", category: "travel"),
            EmojiModel(emoji: "🌇", description: "city dusk, travel", category: "travel"),
            EmojiModel(emoji: "🌁", description: "bridge under fog, travel", category: "travel"),
            EmojiModel(emoji: "🏨", description: "hotel", category: "travel"),

            // MARK: OBJECTS
            EmojiModel(emoji: "🎧", description: "headphones music", category: "objects"),
            EmojiModel(emoji: "🎮", description: "controller gamepad playstation nintendo xbox console", category: "objects"),
            EmojiModel(emoji: "🏎", description: "car f1 race", category: "objects"),
            EmojiModel(emoji: "🚀", description: "space spaceship rocket cosmos", category: "objects"),
            EmojiModel(emoji: "⌚️", description: "apple watch android samsung", category: "objects"),
            EmojiModel(emoji: "📱", description: "iphone phone samsung xiaomi oppo nothing", category: "objects"),
            EmojiModel(emoji: "💻", description: "macbook computer laptop", category: "objects"),
            EmojiModel(emoji: "⌨️", description: "keyboard", category: "objects"),
            EmojiModel(emoji: "🖥", description: "mac compter pc", category: "objects"),
            EmojiModel(emoji: "🖱", description: "mouse", category: "objects"),
            EmojiModel(emoji: "💽", description: "cd", category: "objects"),
            EmojiModel(emoji: "📷", description: "camera", category: "objects"),
            EmojiModel(emoji: "🎥", description: "camera", category: "objects"),
            EmojiModel(emoji: "📺", description: "tv television", category: "objects"),
            EmojiModel(emoji: "💡", description: "smart home bulb", category: "objects"),
            EmojiModel(emoji: "💎", description: "diamond jewlery", category: "objects"),
            EmojiModel(emoji: "🛠", description: "tools", category: "objects"),
            EmojiModel(emoji: "🏺", description: "vase urn", category: "objects"),
            EmojiModel(emoji: "🛏", description: "bed furnitures", category: "objects"),
            EmojiModel(emoji: "🛒", description: "groceries basket shopping", category: "objects"),
            EmojiModel(emoji: "🎁", description: "gift present", category: "objects"),
            EmojiModel(emoji: "🖼", description: "picture art", category: "objects"),
            EmojiModel(emoji: "🎉", description: "celebration birthday", category: "objects"),

            // MARK: UTILITIES
            EmojiModel(emoji: "🚗", description: "red car", category: "utilities"),
            EmojiModel(emoji: "🚙", description: "blue car", category: "utilities"),
            EmojiModel(emoji: "🏍", description: "motorbike", category: "utilities"),
            EmojiModel(emoji: "🛵", description: "motor scooter", category: "utilities"),
            EmojiModel(emoji: "🛞", description: "car wheel", category: "utilities"),
            EmojiModel(emoji: "🚘", description: "red car", category: "utilities"),
            EmojiModel(emoji: "✈️", description: "plane", category: "utilities"),
            EmojiModel(emoji: "🛩", description: "plane jet", category: "utilities"),
            EmojiModel(emoji: "🚁", description: "helicopter", category: "utilities"),
            EmojiModel(emoji: "🛳", description: "cruise pasanger ship", category: "utilities"),
            EmojiModel(emoji: "🏠", description: "home house", category: "utilities"),
            EmojiModel(emoji: "🏡", description: "home house", category: "utilities"),
            EmojiModel(emoji: "🏘", description: "home house", category: "utilities"),

            // MARK: ANIMALS
            EmojiModel(emoji: "🐶", description: "dog puppy, animals", category: "animals"),
            EmojiModel(emoji: "🐰", description: "rabbit, animals", category: "animals"),
            EmojiModel(emoji: "🐥", description: "chick, animals", category: "animals"),
            EmojiModel(emoji: "🐣", description: "chick easter egg, animals", category: "animals"),
            EmojiModel(emoji: "🐴", description: "horse, animals", category: "animals"),
            EmojiModel(emoji: "🦄", description: "unicorn, animals", category: "animals"),
            EmojiModel(emoji: "🦕", description: "dinosaur, animals", category: "animals"),
            EmojiModel(emoji: "🦖", description: "dinosaur t-rex, animals", category: "animals"),
            EmojiModel(emoji: "🦎", description: "lizard, animals", category: "animals"),
            EmojiModel(emoji: "🐢", description: "turtle, animals", category: "animals"),
            EmojiModel(emoji: "🐍", description: "snake, animals", category: "animals"),
            EmojiModel(emoji: "🐑", description: "sheep, animals", category: "animals"),
            EmojiModel(emoji: "🐈", description: "cat, animals", category: "animals"),
            
            // MARK: INVESTING
            EmojiModel(emoji: "🛢", description: "oil petrol stock", category: "investing"),
            EmojiModel(emoji: "💸", description: "money dollars", category: "investing"),
            EmojiModel(emoji: "💵", description: "money dollars", category: "investing"),
            EmojiModel(emoji: "💴", description: "money", category: "investing"),
            EmojiModel(emoji: "💶", description: "money euro", category: "investing"),
            EmojiModel(emoji: "💳", description: "credit card", category: "investing"),
            EmojiModel(emoji: "📈", description: "stock chart", category: "investing"),
            EmojiModel(emoji: "📊", description: "chart", category: "investing"),
        ]
    }
}
