# TextFieldTableViewController

A `UITableViewController` with a `UITextField` inside each `UITableViewCell`

Setup: [How to add a Git repository to your Xcode project][1]

Usage:

```swift
import UIKit
import TextFieldTableViewController

class EnterEmailTableViewController: TextFieldTableViewController {
  init() {
    super.init(title: "Enter Email", placeholders: [["Email"]], texts: [[""]])
  }

  // MARK: - NSCoding

  required init?(coder: NSCoder) {
    fatalError("init(coder:) hasn't been implemented")
  }

  // MARK: - TextFieldTableViewController

  override func configureTextField(_ textField: UITextField, forRowAt indexPath: IndexPath) {
    super.configureTextField(textField, forRowAt: indexPath)
    textField.autocapitalizationType = .none
    textField.keyboardType = .emailAddress
  }

  // MARK: - Actions

  override func doneAction() {
    let email = texts[0][0].trimmingCharacters(in: .whitespacesAndNewlines)
    print("Email entered: \(email)")
  }
}
```

Released under the [Unlicense][2].


  [1]: https://github.com/acani/Libraries
  [2]: http://unlicense.org
