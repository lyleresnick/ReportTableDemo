//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListOneSourceTransformer {
    
    fileprivate let allData: [TransactionModel]?
    
    init( allData: [TransactionModel]? ) {
        self.allData = allData
    }
    
    func transform(output: TransactionListTransformerOutput) {
        
        var grandTotal = 0.0

        if let allData = allData {

            var groupStream = ([.Authorized, .Posted] as [TransactionGroup]).makeIterator()
            var currentGroup = groupStream.next()
            
            var transactionStream = allData.makeIterator()
            var transaction = transactionStream.next()
            
            var minGroup = determineMinGroup( group: currentGroup, transaction: transaction )

            while let localMinGroup = minGroup {
                
                output.appendHeader(group: localMinGroup)
                
                if (transaction == nil) || (localMinGroup != transaction!.group) {
                    output.appendNoTransactionsMessage( group: localMinGroup)
                }
                else {
                
                    var total = 0.0
                    while let localTransaction = transaction, localTransaction.group == localMinGroup {
                        
                        let currentDate = localTransaction.date
                        output.appendSubheader(date: currentDate)
                        
                        while let localTransaction = transaction, (localTransaction.group == localMinGroup) && (localTransaction.date == currentDate) {
                            
                            let amount = localTransaction.amount
                            total += amount
                            grandTotal += amount
                            output.appendDetail(description: localTransaction.description, amount: amount)
                            
                            transaction = transactionStream.next()
                        }
                        output.appendSubfooter()
                    }
                    output.appendFooter(total: total)
                }
                currentGroup = groupStream.next()
                minGroup = determineMinGroup( group: currentGroup, transaction: transaction )
            }
        }
        else {
            output.appendHeader(group: .All)
            output.appendNotFoundMessage( group: .All)
        }
        output.appendGrandFooter(grandTotal: grandTotal)
    }
    
    func determineMinGroup(group: TransactionGroup?, transaction: TransactionModel?) -> TransactionGroup? {
        
        if (group == nil) && (transaction == nil) {
            return nil
        }
        else if group == nil {
            return transaction!.group
        }
        else if transaction == nil {
            return group
        }
        else {
            return (group!.rawValue < transaction!.group.rawValue) ? group : transaction!.group
        }
    }
}
