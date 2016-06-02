import XCTest
import TextFieldTableViewController

class TextFieldTableViewControllerTests: XCTestCase {
    let textFieldTableViewController = TextFieldTableViewController(title: "Welcome", placeholders: [["Email"]], texts: [[""]])

    func testInitWithStyleReuseIdentifier() {
        let tableView = textFieldTableViewController.tableView
        let cell = textFieldTableViewController.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! TextFieldTableViewCell
        XCTAssertEqual(cell.selectionStyle, UITableViewCellSelectionStyle.None)
        XCTAssertEqual(cell.textField.superview, cell.contentView)
        XCTAssertFalse(cell.textField.translatesAutoresizingMaskIntoConstraints)

        // TODO: Test specific constraints
        // I think I did this in chats somewhere
        // I think I have generic code to test constraints
    }

    func testTextFieldForRowAtIndexPath() {
        let tableView = textFieldTableViewController.tableView
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        textFieldTableViewController.tableView(tableView, cellForRowAtIndexPath: indexPath) as! TextFieldTableViewCell
        let textField = tableView.textFieldForRowAtIndexPath(indexPath)
        XCTAssertNotNil(textField)
    }
}
