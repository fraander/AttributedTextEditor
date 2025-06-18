import SwiftUI

public struct ComposerTextEditorView: View {
    @Binding var text: AttributedString
    @Binding var selection: AttributedTextSelection
    
    var placeholder: String = "What's on your mind?"
    
    @FocusState private var isFocused: Bool
    
    @State private var isPlaceholder = true
    @State private var processor = ComposerTextProcessor()
    
    @ScaledMetric private var fontSize: CGFloat = 20
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text, selection: $selection)
                .textInputFormattingControlVisibility(.hidden, for: .all) // hide all built-in formatting controls
                .font(.system(size: fontSize))
                .frame(maxWidth: .infinity)
                .focused($isFocused)
                .textEditorStyle(.plain)
                .attributedTextFormattingDefinition(ComposerFormattingDefinition())
                .onChange(of: text, initial: true) { oldValue, newValue in
                    isPlaceholder = newValue.characters.isEmpty
                    processor.processText(&text)
                }
            
            if isPlaceholder {
                Text(placeholder)
                    .font(.system(size: fontSize))
                    .foregroundStyle(.secondary)
                    .padding(.top, 6)
                    .padding(.leading, 8)
            }
        }
    }
}
