//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

class TransactionListTwoSourceTransformer {

    private let authorizedTransactions: [TransactionModel]?
    private let postedTransactions: [TransactionModel]?

    init( authorizedTransactions: [TransactionModel]?, postedTransactions: [TransactionModel]?) {
        self.authorizedTransactions = authorizedTransactions
        self.postedTransactions = postedTransactions
    }

    func transform(output: TransactionListTransformerOutput) {

        var grandTotal = 0.0
        grandTotal += transform( transactions: authorizedTransactions, group: .authorized, output: output)
        grandTotal += transform( transactions: postedTransactions, group: .posted, output: output )
        output.appendGrandFooter(grandTotal: grandTotal)
    }

    private func transform(transactions: [TransactionModel]?, group: TransactionGroup, output: TransactionListTransformerOutput ) -> Double {
        
        var total = 0.0
        output.appendHeader(group: group)
        
        if let transactions = transactions {
            
            if transactions.count == 0 {
                output.appendNoTransactionsMessage( group: group)
            }
            else {
                var transactionStream = transactions.makeIterator()
                var transaction = transactionStream.next()

                while let localTransaction = transaction {
                    
                    let currentDate = localTransaction.date
                    output.appendSubheader(date: currentDate)
                    
                    while let localTransaction = transaction,
                        localTransaction.date == currentDate {
                        
                        total += localTransaction.amount
                        output.appendDetail(description: localTransaction.description, amount: localTransaction.amount)
                        transaction = transactionStream.next()
                    }
                    output.appendSubfooter()
                }
                output.appendFooter(total: total)
            }
        }
        else {
            output.appendNotFoundMessage(group: group)
        }
        return total
    }
}
