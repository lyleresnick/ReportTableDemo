//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class AccountDetailsTransactionListAdapter: NSObject {
    
    fileprivate var rowList = [Row]()
    fileprivate var odd = false
}

// MARK: - TransactionTransformerOutput

extension AccountDetailsTransactionListAdapter: TransactionTransformerOutput {

    func appendHeader( title: String ) {
    
        rowList.append(.header(title: title));
    }
    
    func appendSubheader( date: String ) {
    
        odd = !odd;
        rowList.append(.subheader(title: date, odd: odd))
    }
    
    func appendDetail( description: String, amount: String) {
    
        rowList.append( .detail(description: description, amount: amount, odd: odd));
    }
    
    func appendSubfooter() {
    
        rowList.append(.subfooter( odd: odd ));
    }
    
    func appendFooter( total: String) {
    
        odd = !odd;
        rowList.append(.footer(total: total, odd: odd));
    }
    
    func appendMessage( message: String) {
    
        rowList.append(.message(message: message));
    }
}

// MARK: - UITableViewDataSource

extension AccountDetailsTransactionListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = rowList[ indexPath.row ]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellId.rawValue, for: indexPath)
        (cell as! TransactionCell).bind(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList.count
    }
}

// MARK: - UITableViewDelegate

extension AccountDetailsTransactionListAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowList[ indexPath.row ].height
    }
}

// MARK: - Cells

private protocol TransactionCell {
    func bind(row: Row)
}

extension TransactionCell where Self: UITableViewCell {
    
    fileprivate func setBackgroundColour(odd: Bool ) {
        
        let backgroundRgb = odd ? 0xF7F8FC : 0xDDDDDD
        backgroundColor = UIColor( rgb: backgroundRgb )
    }
}

class HeaderCell: UITableViewCell, TransactionCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .header( title ) = row else { fatalError("Expected: header") }
        titleLabel.text = title + " Transactions"
    }
}

class SubheaderCell: UITableViewCell, TransactionCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .subheader( title, odd ) = row else { fatalError("Expected: subheader") }
        titleLabel.text = title
        setBackgroundColour(odd: odd)
    }
}

class DetailCell: UITableViewCell, TransactionCell {
    
    @IBOutlet fileprivate var descriptionLabel: UILabel!
    @IBOutlet fileprivate var amountLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .detail( description, amount, odd ) = row else { fatalError("Expected: detail") }
        descriptionLabel.text = description
        amountLabel.text = amount
        setBackgroundColour(odd: odd)
    }
}

class SubfooterCell: UITableViewCell, TransactionCell {
    
    fileprivate func bind(row: Row) {
        
        guard case let .subfooter( odd ) = row else { fatalError("Expected: subfooter") }
        setBackgroundColour(odd: odd)
    }
}

class FooterCell: UITableViewCell, TransactionCell {
    
    @IBOutlet fileprivate var totalLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .footer(total, odd) = row else { fatalError("Expected: footer") }
        totalLabel.text = total
        setBackgroundColour(odd: odd)
    }
}

class MessageCell: UITableViewCell, TransactionCell {
    
    @IBOutlet fileprivate var messageLabel: UILabel!
    
    fileprivate  func bind(row: Row) {
        
        guard case let .message( message ) = row else { fatalError("Expected: message") }
        messageLabel.text = message
        setBackgroundColour(odd: false)
    }
}

// MARK: - Rows

private enum CellId: String {
    
    case header
    case subheader
    case detail
    case subfooter
    case footer
    case message
}

private enum Row {
    case header( title: String )
    case subheader( title: String, odd: Bool )
    case detail( description: String, amount: String, odd: Bool )
    case subfooter( odd : Bool )
    case footer( total: String, odd: Bool )
    case message( message: String )
    
    var cellId: CellId {
        get {
            switch self {
            case .header:
                return .header
            case .subheader:
                return .subheader
            case  .detail:
                return .detail
            case .subfooter:
                return .subfooter
            case .footer:
                return .footer
            case .message:
                return .message
            }
        }
    }
    
    var height: CGFloat {
        get {
            switch self {
            case .header:
                return 60.0
            case .subheader:
                return 34.0
            case .detail:
                return 18.0
            case .subfooter:
                return 18.0
            case .footer:
                return 44.0
            case .message:
                return 100.0
            }
        }
    }
}
