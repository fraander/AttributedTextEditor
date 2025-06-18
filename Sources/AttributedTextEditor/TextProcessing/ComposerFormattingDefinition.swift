import SwiftUI

/// The formatting definition for composer text
struct ComposerFormattingDefinition: AttributedTextFormattingDefinition {
  typealias Scope = AttributeScopes.ComposerAttributes
  
  var body: some AttributedTextFormattingDefinition<Scope> {
      PatternColorConstraint()
      PatternUnderlineConstraint()
      PatternFontConstraint()
      PatternStrikethroughConstraint()
  }
}

/// Applies text size based on constraints
struct PatternFontConstraint: AttributedTextValueConstraint {
    typealias Scope = AttributeScopes.ComposerAttributes
    typealias AttributeKey = AttributeScopes.SwiftUIAttributes.FontAttribute
    
    func constrain(_ container: inout Attributes) {
        if let pattern = container.textPattern {
            container.font = pattern.font
        } else {
            container.font = nil
        }
    }
}

/// Constraint that applies colors based on text patterns
struct PatternColorConstraint: AttributedTextValueConstraint {
  typealias Scope = AttributeScopes.ComposerAttributes
  typealias AttributeKey = AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute
  
  func constrain(_ container: inout Attributes) {
    if let pattern = container.textPattern {
      container.foregroundColor = pattern.color
    } else {
      container.foregroundColor = nil
    }
  }
}

/// Constraint that underlines links and underline
struct PatternUnderlineConstraint: AttributedTextValueConstraint {
  typealias Scope = AttributeScopes.ComposerAttributes
  typealias AttributeKey = AttributeScopes.SwiftUIAttributes.UnderlineStyleAttribute
  
  func constrain(_ container: inout Attributes) {
      if container.textPattern == .link || container.textPattern == .underline {
      container.underlineStyle = .single
    } else {
      container.underlineStyle = nil
    }
  }
}

/// Constraint that strikesthrough
struct PatternStrikethroughConstraint: AttributedTextValueConstraint {
  typealias Scope = AttributeScopes.ComposerAttributes
    typealias AttributeKey = AttributeScopes.SwiftUIAttributes.StrikethroughStyleAttribute
  
  func constrain(_ container: inout Attributes) {
      if let shouldStrike = container.textPattern?.shouldStrike {
          if shouldStrike {
              container.strikethroughStyle = .single
          } else {
              container.strikethroughStyle = nil
          }
    } else {
        container.strikethroughStyle = nil
    }
  }
}
