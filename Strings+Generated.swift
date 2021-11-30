// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Answer {
    /// 
    public static let empty = L10n.tr("Localizable", "answer.empty")
    public enum Custom {
      /// customAnswer
      public static let key = L10n.tr("Localizable", "answer.custom.key")
    }
    public enum Default {
      /// Opps
      public static let text = L10n.tr("Localizable", "answer.default.text")
    }
    public enum Placeholder {
      /// Enter your custom answer
      public static let text = L10n.tr("Localizable", "answer.placeholder.text")
    }
  }

  public enum AppName {
    /// ShakeApp
    public static let text = L10n.tr("Localizable", "appName.text")
  }

  public enum Greeting {
    /// Hello
    public static let text = L10n.tr("Localizable", "greeting.text")
  }

  public enum Question {
    public enum Placeholder {
      /// Enter your question and shake the phone
      public static let text = L10n.tr("Localizable", "question.placeholder.text")
    }
  }

  public enum Title {
    /// History
    public static let history = L10n.tr("Localizable", "title.history")
    /// Main
    public static let main = L10n.tr("Localizable", "title.main")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
