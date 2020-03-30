import UIKit

open class TextFieldTableViewCell: UITableViewCell {
  open var textFieldLeftLayoutConstraint: NSLayoutConstraint!
  public let textField = PaddedTextField(frame: .zero)

  // MARK: - UITableViewCell

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none

    if #available(iOS 10, *) { textField.adjustsFontForContentSizeCategory = true }
    textField.font = .preferredFont(forTextStyle: .body)
    contentView.addSubview(textField)

    textField.translatesAutoresizingMaskIntoConstraints = false
    textFieldLeftLayoutConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: separatorInset.left+1)
    NSLayoutConstraint.activate([
      textFieldLeftLayoutConstraint,
      NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
    ])
  }

  // MARK: - NSCoding

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) hasn't been implemented")
  }
}

extension UITableView {
  public func indexPath(for textField: UITextField) -> IndexPath? {
    return indexPath(for: textField.superview!.superview! as! UITableViewCell)
  }

  public func textFieldForRow(at indexPath: IndexPath) -> UITextField? {
    return (cellForRow(at: indexPath) as! TextFieldTableViewCell?)?.textField
  }
}

open class PaddedTextField: UITextField {
  open override var intrinsicContentSize: CGSize {
    var returnValue = super.intrinsicContentSize
    returnValue.height *= 2
    return returnValue
  }
}
