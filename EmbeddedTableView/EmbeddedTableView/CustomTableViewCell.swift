//
//  CustomTableViewCell.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cellId: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellId.text = ""
//        let indexPath = self.indexPath.flatMap { print($0) }
        print("awake: \(self.tag)")
        cellId.text = "\(self.tag)"
    }
    
    override func prepareForReuse() {
//        let indexPath = self.indexPath.flatMap { print($0) }
        print("reuse: \(self.tag)")
        cellId.text = "\(self.tag)"
    }
    
//    func getIndexPath() -> IndexPath? {
//        guard let superView = self.superview as? UITableView else {
//            print("superview is not a UITableView - getIndexPath")
//            return nil
//        }
//        let indexPath = superView.indexPath(for: self)
//        return indexPath
//    }

}

//
//extension UITableViewCell {
//    var tableView: UITableView? {
//        return self.next(of: UITableView.self)
//    }
//
//    var indexPath: IndexPath? {
//        return self.tableView?.indexPath(for: self)
//    }
//}
//
//extension UIResponder {
//    /**
//     * Returns the next responder in the responder chain cast to the given type, or
//     * if nil, recurses the chain until the next responder is nil or castable.
//     */
//    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
//        return self.next.flatMap({ $0 as? U ?? $0.next() })
//    }
//}
