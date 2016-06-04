# TextFieldTableViewController

A `UITableViewController` with a `UITextField` inside each `UITableViewCell`

Setup: [How to add a Git repository to your Xcode project][1]

Dependencies:

* [AutoLayout][2]

Usage:

```swift
import UIKit
import TextFieldTableViewController

class EnterEmailTableViewController: TextFieldTableViewController {
    init() {
        super.init(title: "Enter Email", placeholders: [["Email"]], texts: [[""]])
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding

    // MARK: - TextFieldTableViewController

    override func configureTextField(textField: UITextField, forIndexPath indexPath: NSIndexPath) {
        super.configureTextField(textField, forIndexPath: indexPath)
        textField.autocapitalizationType = .None
        textField.keyboardType = .EmailAddress
    }

    // MARK: - Actions

    override func doneAction() {
        let email = texts[0][0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if !email.isValidEmail { return alert(title: "", message: Validator.invalidEmailMessage) }
        print("Email entered: \(email)")
    }
}
```

Released under the [Unlicense][2].


  [1]: https://github.com/acani/Libraries
  [2]: https://github.com/acani/AutoLayout
  [3]: http://unlicense.org
