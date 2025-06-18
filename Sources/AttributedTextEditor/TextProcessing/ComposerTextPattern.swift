import SwiftUI
import Foundation

// Custom attribute keys for text patterns
struct TextPatternAttribute: CodableAttributedStringKey {
    typealias Value = ComposerTextPattern
    
    static let name = "ComposerUI.TextPatternAttribute"
    static let inheritedByAddedText: Bool = false
    static let invalidationConditions: Set<AttributedString.AttributeInvalidationCondition>? = [.textChanged]
}

extension AttributeScopes {
    struct ComposerAttributes: AttributeScope {
        let textPattern: TextPatternAttribute
        let foregroundColor: AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
        let underlineStyle: AttributeScopes.SwiftUIAttributes.UnderlineStyleAttribute
        let strikethroughStyle: AttributeScopes.SwiftUIAttributes.StrikethroughStyleAttribute
        let font: AttributeScopes.SwiftUIAttributes.FontAttribute
    }
}

extension AttributeDynamicLookup {
    subscript<T: AttributedStringKey>(
        dynamicMember keyPath: KeyPath<AttributeScopes.ComposerAttributes, T>
    ) -> T {
        self[T.self]
    }
}

enum ComposerTextPattern: String, CaseIterable, Codable {
    case h1
    case h2
    case h3
    case bold
    case italic
    case underline
    case strikethrough
    case link
    case blockquote
    case unorderedList
    case orderedList
    case uncheckedBox
    case checkedBox
    case checkedBoxText
    case inlineCode
    case codeBlock
    
    var pattern: String {
        switch self {
        case .bold: return "\\*\\*.*?\\*\\*"
        case .italic: return "\\*.*?\\*"
        case .link: return "\\[.*?\\]\\(.*?\\)"
        case .blockquote: return "^> .+"
        case .underline: return "__.*?__"
        case .strikethrough: return "~.*?~"
        case .h1: return "(?m)^# (?!#).+"
        case .h2: return "(?m)^## (?!#).+"
        case .h3: return "(?m)^### (?!#).+"
        case .unorderedList: return "(?m)^\\s*[-*+] (?!\\[)"
        case .orderedList: return "(?m)^\\s*\\d+\\. "
        case .uncheckedBox: return "- \\[ \\]"
        case .checkedBox: return "- \\[x\\]"
        case .checkedBoxText: return "(?m)^- \\[x\\] .+$"
        case .inlineCode: return "`[^`\\n]+`"
        case .codeBlock: return "(?m)^```[\\s\\S]*?^```"
        }
    }
    
    var shouldStrike: Bool {
        switch self {
        case .strikethrough: true
        case .checkedBoxText: true
        default: false
        }
    }
    
    var font: Font {
        switch self {
        case .h1: return Font.largeTitle.bold()
        case .h2: return Font.title3.bold()
        case .h3: return Font.headline
        case .bold: return Font.body.bold()
        case .italic: return Font.body.italic()
        case .underline: return Font.body
        case .strikethrough: return Font.body
        case .link: return Font.body
        case .blockquote: return Font.system(.body, design: .serif)
        case .unorderedList: return Font.system(.body, design: .monospaced, weight: .bold)
        case .orderedList: return Font.system(.body, design: .monospaced, weight: .bold)
        case .uncheckedBox: return Font.system(.body, design: .monospaced, weight: .bold)
        case .checkedBox: return Font.system(.body, design: .monospaced, weight: .bold)
        case .checkedBoxText: return Font.body
        case .inlineCode: return Font.system(.body, design: .monospaced, weight: .semibold)
        case .codeBlock: return Font.system(.body, design: .monospaced, weight: .semibold)
        }
    }
    
    var color: Color {
        switch self {
        case .strikethrough: return .secondary
        case .link: return .accentColor
        case .blockquote: return .teal
        case .unorderedList: return .accentColor
        case .orderedList: return .accentColor
        case .checkedBox: return .accentColor
        case .uncheckedBox: return .accentColor
        case .checkedBoxText: return .secondary
        case .inlineCode: return .teal
        case .codeBlock: return .teal
        default: return .primary
        }
    }
    
    func matches(_ text: String) -> Bool {
        return text.range(of: self.pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
}
