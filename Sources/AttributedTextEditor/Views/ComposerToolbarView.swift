//import DesignSystem
import Network
import SwiftUI

public struct ComposerToolbarView: ToolbarContent {
    @Binding var text: AttributedString
    @Binding var selection: AttributedTextSelection
    
    var dismissKeyboard: () -> Void = { }
    
    var placement: ToolbarItemPlacement {
        #if os(iOS)
        .keyboard
        #elseif os(macOS)
        ToolbarItemPlacement.principal
        #endif
    }
    
    public var body: some ToolbarContent {
        ToolbarItemGroup(placement: placement) {
            let count = text.characters.count
            Text("\(count)")
                .font(.subheadline)
                .contentTransition(.numericText(value: Double(count)))
                .monospacedDigit()
                .lineLimit(1)
                .animation(.smooth, value: count)
            
            Spacer()
            
            Menu("Headings", systemImage: "textformat") {
                Button("H1", systemImage: "1.square") {}
                Button("H2", systemImage: "2.square") {}
                Button("H3", systemImage: "3.square") {}
                Button("Body", systemImage: "textformat.size") {}
            }
            
            Menu("Bold/Underline/Italic", systemImage: "bold.italic.underline") {
                Button("Bold", systemImage: "bold") {}
                Button("Italic", systemImage: "italic") {}
                Button("Underline", systemImage: "underline") {}
            }
            
            Menu("Elements", systemImage: "switch.2") {
                Button("Link", systemImage: "link") {}
                Button("Blockquote", systemImage: "text.quote") {}
            }
            
            Menu("Lists", systemImage: "list.bullet") {
                Button("Unordered List", systemImage: "list.bullet") {}
                Button("Ordered List", systemImage: "list.number") {}
                Button("Checkbox", systemImage: "checklist") {}
            }
            
            Spacer()
            
            Button("Dismiss keyboard", systemImage: "keyboard.chevron.compact.down", action: dismissKeyboard)
        }
    }
}
