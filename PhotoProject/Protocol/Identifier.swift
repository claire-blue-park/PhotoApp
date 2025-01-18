import UIKit

protocol IdentifierProtocol {
    static var ofIdentifier: String { get }
}

extension UIViewController: IdentifierProtocol {
    static var ofIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierProtocol {
    static var ofIdentifier: String {
        return String(describing: self)
    }
    
}
