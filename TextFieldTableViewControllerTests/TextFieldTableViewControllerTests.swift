import XCTest
import TextFieldTableViewController

class TextFieldTableViewControllerTests: XCTestCase {
    let textFieldTableViewController = TextFieldTableViewController(title: "Welcome", placeholders: [["Email"]], texts: [[""]])

    func testInitWithStyleReuseIdentifier() {
        let tableView = textFieldTableViewController.tableView!
        let cell = textFieldTableViewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TextFieldTableViewCell

        XCTAssertEqual(cell.selectionStyle, .none)
        XCTAssertEqual(cell.textField.superview, cell.contentView)
        XCTAssertFalse(cell.textField.translatesAutoresizingMaskIntoConstraints)

        // TODO: Test specific constraints
        // I think I did this in chats somewhere
        // I think I have generic code to test constraints
    }

    func testTextFieldForRow() {
        let tableView = textFieldTableViewController.tableView!
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = textFieldTableViewController.tableView(tableView, cellForRowAt: indexPath) as! TextFieldTableViewCell
        let textField = tableView.textFieldForRow(at: indexPath)
        XCTAssertNotNil(textField)
        XCTAssertEqual(textField, cell.textField)
    }
}
