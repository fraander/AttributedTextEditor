import SwiftUI

public struct ComposerTextEditorView: View {
    @Binding var text: AttributedString
    @Binding var selection: AttributedTextSelection
    
    var placeholder: String
    
    @FocusState private var isFocused: Bool
    
    @State private var isPlaceholder = true
    @State private var processor = ComposerTextProcessor()
    
    public init(
        text: Binding<AttributedString>,
        selection: Binding<AttributedTextSelection>,
        placeholder: String = "What's on your mind?"
    ) {
        _text = text
        _selection = selection
        self.placeholder = placeholder
        self.isPlaceholder = true
        self.processor = ComposerTextProcessor()
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text, selection: $selection)
                .textInputFormattingControlVisibility(.hidden, for: .all) // hide all built-in formatting controls
                .font(.body)
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
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                    .padding(.leading, 8)
            }
        }
    }
}
