//  Copyright © 2017 Cellarpoint. All rights reserved.

import UIKit

// MARK: - Cells

protocol TransactionListCell {
    func bind(row: TransactionListRow)
}

extension TransactionListCell where Self: UITableViewCell {
    
    fileprivate func setBackgroundColour(odd: Bool ) {
        
        let backgroundRgb = odd ? 0xF7F8FC : 0xDDDDDD
        backgroundColor = UIColor( rgb: backgroundRgb )
    }
}

class TransactionListHeaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .header( title ) = row else { fatalError("Expected: header") }
        titleLabel.text = title + " Transactions"
    }
}

class TransactionListSubheaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .subheader( title, odd ) = row else { fatalError("Expected: subheader") }
        titleLabel.text = title
        setBackgroundColour(odd: odd)
    }
}

class TransactionListDetailCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .detail( description, amount, odd ) = row else { fatalError("Expected: detail") }
        descriptionLabel.text = description
        amountLabel.text = amount
        setBackgroundColour(odd: odd)
    }
}

class TransactionListSubfooterCell: UITableViewCell, TransactionListCell {
    
    func bind(row: TransactionListRow) {
        
        guard case let .subfooter( odd ) = row else { fatalError("Expected: subfooter") }
        setBackgroundColour(odd: odd)
    }
}

class TransactionListFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var totalLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .footer(total, odd) = row else { fatalError("Expected: footer") }
        totalLabel.text = total
        setBackgroundColour(odd: odd)
    }
}

class TransactionListGrandFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var totalLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .grandfooter(total) = row else { fatalError("Expected: grandfooter") }
        totalLabel.text = total
    }
}

class TransactionListMessageCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var messageLabel: UILabel!
    
    func bind(row: TransactionListRow) {
        
        guard case let .message( message ) = row else { fatalError("Expected: message") }
        messageLabel.text = message
        setBackgroundColour(odd: true)
    }
}

