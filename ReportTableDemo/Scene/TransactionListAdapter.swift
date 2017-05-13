//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListAdapter: NSObject {
    
    fileprivate var rowList = [Row]()
    fileprivate var odd = false
}

// MARK: - TransactionTransformerOutput

extension TransactionListAdapter: TransactionListTransformerOutput {

    
    private static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )

    func appendHeader( group: TransactionGroup ) {
    
        rowList.append(.header(title: group.toString()));
    }
    
    func appendSubheader( date: Date ) {
    
        odd = !odd;
        let dateString = TransactionListAdapter.outboundDateFormatter.string(from: date)
        rowList.append(.subheader(title: dateString, odd: odd))
    }
    
    func appendDetail( description: String, amount: Double) {
    
        rowList.append( .detail(description: description, amount: amount.asString, odd: odd));
    }
    
    func appendSubfooter() {
    
        rowList.append(.subfooter( odd: odd ));
    }
    
    func appendFooter( total: Double) {
    
        odd = !odd;
        rowList.append(.footer(total: total.asString, odd: odd));
    }
    
    func appendGrandFooter(grandTotal: Double) {
        
        rowList.append(.grandfooter(total: grandTotal.asString))
    }
    
    func appendNotFoundMessage(group: TransactionGroup) {
    
        rowList.append(.message(message: "\(group.toString()) Transactions are not currently available. You might want to call us and tell us what you think of that!" ));
    }
    
    func appendNoTransactionsMessage(group: TransactionGroup) {
        
        rowList.append(.message(message: "There are no \(group.toString()) Transactions in this period" ));
    }
}

extension Double {
    var asString: String {
        return String(format: "%0.2f", self)
    }
}



// MARK: - UITableViewDataSource

extension TransactionListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = rowList[ indexPath.row ]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellId.rawValue, for: indexPath)
        (cell as! TransactionListCell).bind(row: row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TransactionListAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowList[ indexPath.row ].height
    }
}

// MARK: - Cells

private protocol TransactionListCell {
    func bind(row: Row)
}

extension TransactionListCell where Self: UITableViewCell {
    
    fileprivate func setBackgroundColour(odd: Bool ) {
        
        let backgroundRgb = odd ? 0xF7F8FC : 0xDDDDDD
        backgroundColor = UIColor( rgb: backgroundRgb )
    }
}

class TransactionListHeaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .header( title ) = row else { fatalError("Expected: header") }
        titleLabel.text = title + " Transactions"
    }
}

class TransactionListSubheaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .subheader( title, odd ) = row else { fatalError("Expected: subheader") }
        titleLabel.text = title
        setBackgroundColour(odd: odd)
    }
}

class TransactionListDetailCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var descriptionLabel: UILabel!
    @IBOutlet fileprivate var amountLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .detail( description, amount, odd ) = row else { fatalError("Expected: detail") }
        descriptionLabel.text = description
        amountLabel.text = amount
        setBackgroundColour(odd: odd)
    }
}

class TransactionListSubfooterCell: UITableViewCell, TransactionListCell {
    
    fileprivate func bind(row: Row) {
        
        guard case let .subfooter( odd ) = row else { fatalError("Expected: subfooter") }
        setBackgroundColour(odd: odd)
    }
}

class TransactionListFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var totalLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .footer(total, odd) = row else { fatalError("Expected: footer") }
        totalLabel.text = total
        setBackgroundColour(odd: odd)
    }
}

class TransactionListGrandFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var totalLabel: UILabel!
    
    fileprivate func bind(row: Row) {
        
        guard case let .grandfooter(total) = row else { fatalError("Expected: grandfooter") }
        totalLabel.text = total
    }
}

class TransactionListMessageCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet fileprivate var messageLabel: UILabel!
    
    fileprivate  func bind(row: Row) {
        
        guard case let .message( message ) = row else { fatalError("Expected: message") }
        messageLabel.text = message
        setBackgroundColour(odd: true)
    }
}

// MARK: - Rows

private enum CellId: String {
    
    case header
    case subheader
    case detail
    case subfooter
    case footer
    case grandfooter
    case message
}

private enum Row {
    case header( title: String )
    case subheader( title: String, odd: Bool )
    case detail( description: String, amount: String, odd: Bool )
    case subfooter( odd : Bool )
    case footer( total: String, odd: Bool )
    case grandfooter(total: String )
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
            case .grandfooter:
                return .grandfooter
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
            case .grandfooter:
                return 60.0
            case .message:
                return 100.0
            }
        }
    }
}

