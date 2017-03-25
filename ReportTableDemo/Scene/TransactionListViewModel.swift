//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit


typealias TransactionViewModelIterator = AnyIterator<TransactionViewModel>

func transactionViewModelGenerator( transactions: [TransactionModel]) -> TransactionViewModelIterator {
    
    var generator = transactions.makeIterator()
    
    return AnyIterator {
        return TransactionViewModel(transaction: generator.next() )
    }
}
