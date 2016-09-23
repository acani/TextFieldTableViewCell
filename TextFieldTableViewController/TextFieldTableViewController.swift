import UIKit

open class TextFieldTableViewController: UITableViewController, UITextFieldDelegate {
    open let placeholders: [[String]]
    open var texts: [[String]]
    private var didBecomeFirstResponder = false

    public init(title: String, placeholders: [[String]], texts: [[String]]) {
        self.placeholders = placeholders
        self.texts = texts
        super.init(style: .grouped)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TextFieldTableViewController.doneAction))
        self.title = title
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding

    // MARK: - UIViewController

    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: String(describing: TextFieldTableViewCell.self))
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.textFieldForRow(at: IndexPath(row: 0, section: 0))?.becomeFirstResponder()
    }

    // MARK: - UITableViewDataSource

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return texts.count
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts[section].count
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextFieldTableViewCell.self), for: indexPath) as! TextFieldTableViewCell
        let textField = cell.textField
        configureTextField(textField, forRowAt: indexPath)
        if !didBecomeFirstResponder { didBecomeFirstResponder = textField.becomeFirstResponder() }
        return cell
    }

    open func configureTextField(_ textField: UITextField, forRowAt indexPath: IndexPath) {
        textField.addTarget(self, action: #selector(TextFieldTableViewController.textFieldDidChange(_:)), for: .editingChanged)
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.returnKeyType = !isLastIndexPath(indexPath) ? .next : .done
        textField.placeholder = placeholders[indexPath.section][indexPath.row]
        textField.text = texts[indexPath.section][indexPath.row]
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidChange(_ textField: UITextField) {
        let indexPath = tableView.indexPath(for: textField)!
        texts[indexPath.section][indexPath.row] = textField.text!
    }

    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let indexPath = tableView.indexPath(for: textField)!
        var nextIndexPath: IndexPath
        if !isLastRow(indexPath.row, inSection: indexPath.section) {
            nextIndexPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
        } else if !isLastSection(indexPath.section) {
            nextIndexPath = IndexPath(row: 0, section: indexPath.section+1)
        } else {
            doneAction()
            return false
        }
        tableView.textFieldForRow(at: nextIndexPath)!.becomeFirstResponder()
        return false
    }

    // MARK: - Actions

    open func doneAction() {
        // Subclasses override this method
    }

    // MARK: - Helpers

    private func isLastRow(_ row: Int, inSection section: Int) -> Bool {
        return row == texts[section].count-1
    }

    private func isLastSection(_ section: Int) -> Bool {
        return section == texts.count-1
    }

    private func isLastIndexPath(_ indexPath: IndexPath) -> Bool {
        return isLastSection(indexPath.section) && isLastRow(indexPath.row, inSection: indexPath.section)
    }
}
