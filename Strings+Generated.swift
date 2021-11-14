// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Enter your custom answer
  public static let answerTextPlaceHolder = L10n.tr("Localizable", "AnswerTextPlaceHolder")
  /// ShakeApp
  public static let appName = L10n.tr("Localizable", "AppName")
  /// customAnswer
  public static let customAnswerKey = L10n.tr("Localizable", "CustomAnswerKey")
  /// Opps
  public static let defaultAnswer = L10n.tr("Localizable", "DefaultAnswer")
  /// Hello
  public static let greeting = L10n.tr("Localizable", "Greeting")
  /// Enter your question and shake the phone
  public static let questionTextPlaceHolder = L10n.tr("Localizable", "QuestionTextPlaceHolder")
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
