import XCTest
import TextFieldTableViewController

class TextFieldTableViewControllerTests: XCTestCase {
  func testInitWithStyleReuseIdentifier() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let vc = TextFieldTableViewController(placeholders: [["Email"]], texts: [[""]])
    window.rootViewController = vc
    window.makeKeyAndVisible()
    let tableView = vc.tableView!
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = tableView.cellForRow(at: indexPath) as! TextFieldTableViewCell
    XCTAssertEqual(cell.selectionStyle, .none)
    XCTAssertEqual(cell.textField.superview, cell.contentView)
    XCTAssertFalse(cell.textField.translatesAutoresizingMaskIntoConstraints)
  }

  func testTextFieldForRow() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let vc = TextFieldTableViewController(placeholders: [["Email"]], texts: [[""]])
    window.rootViewController = vc
    window.makeKeyAndVisible()
    let tableView = vc.tableView!
    let indexPath = IndexPath(row: 0, section: 0)
    let textField = tableView.textFieldForRow(at: indexPath)!
    let cell = tableView.cellForRow(at: indexPath) as! TextFieldTableViewCell
    XCTAssertNotNil(textField)
    XCTAssertEqual(textField, cell.textField)
  }
}
