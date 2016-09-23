import UIKit
import AutoLayout

open class TextFieldTableViewCell: UITableViewCell {
    open var textFieldLeftLayoutConstraint: NSLayoutConstraint!
    open let textField = UITextField(frame: .zero)

    // MARK: - UITableViewCell

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        let insets = UIEdgeInsets(top: 0, left: separatorInset.left+1, bottom: 0, right: 0)
        let constraints = NSLayoutConstraint.constraints(withSubview: textField, superview: contentView, insets: insets)
        textFieldLeftLayoutConstraint = constraints[1]
        NSLayoutConstraint.activate(constraints)
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding
}

extension UITableView {
    public func indexPath(for textField: UITextField) -> IndexPath? {
        return indexPath(for: textField.superview!.superview! as! UITableViewCell)
    }

    public func textFieldForRow(at indexPath: IndexPath) -> UITextField? {
        return (cellForRow(at: indexPath) as! TextFieldTableViewCell?)?.textField
    }
}
