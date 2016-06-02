import UIKit

public class TextFieldTableViewController: UITableViewController, UITextFieldDelegate {
    public let placeholders: [[String]]
    public var texts: [[String]]
    var didSetFirstResponder = false

    public init(title: String, placeholders: [[String]], texts: [[String]]) {
        self.placeholders = placeholders
        self.texts = texts
        super.init(style: .Grouped)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(TextFieldTableViewController.doneAction))
        self.title = title
    }

    // MARK: - UIViewController

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(TextFieldTableViewCell.self, forCellReuseIdentifier: "TextFieldCell")
    }

    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.textFieldForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.becomeFirstResponder()
    }

    // MARK: - UITableViewController

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewDataSource

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return texts.count
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts[section].count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as! TextFieldTableViewCell
        let textField = cell.textField
        configureTextField(textField, forIndexPath: indexPath)
        if !didSetFirstResponder { didSetFirstResponder = textField.becomeFirstResponder() }
        return cell
    }

    public func configureTextField(textField: UITextField, forIndexPath indexPath: NSIndexPath) {
        textField.addTarget(self, action: #selector(TextFieldTableViewController.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        textField.autocorrectionType = .No
        textField.clearButtonMode = .WhileEditing
        textField.delegate = self
        textField.returnKeyType = !isLastIndexPath(indexPath) ? .Next : .Done
        textField.placeholder = placeholders[indexPath.section][indexPath.row]
        textField.text = texts[indexPath.section][indexPath.row]
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidChange(textField: UITextField) {
        let indexPath = tableView.indexPathForTextField(textField)!
        texts[indexPath.section][indexPath.row] = textField.text!
    }

    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        let indexPath = tableView.indexPathForTextField(textField)!
        var nextIndexPath: NSIndexPath
        if !isLastRow(indexPath.row, inSection: indexPath.section) {
            nextIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
        } else if !isLastSection(indexPath.section) {
            nextIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section+1)
        } else {
            doneAction()
            return false
        }
        tableView.textFieldForRowAtIndexPath(nextIndexPath)!.becomeFirstResponder()
        return false
    }

    // MARK: - Actions

    public func doneAction() {
        // Subclasses override this method
    }

    // MARK: - Helpers

    private func isLastRow(row: Int, inSection section: Int) -> Bool {
        return row == texts[section].count-1
    }

    private func isLastSection(section: Int) -> Bool {
        return section == texts.count-1
    }

    private func isLastIndexPath(indexPath: NSIndexPath) -> Bool {
        return isLastSection(indexPath.section) && isLastRow(indexPath.row, inSection: indexPath.section)
    }
}
