//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListOneSourceTransformer {
    
    fileprivate let allData: [TransactionModel]
    
    init( allData: [TransactionModel] ) {
        self.allData = allData
    }
    
    func transform(output: TransactionListTransformerOutput) {
        
        var groupStream = ([.Authorized, .Posted] as [TransactionGroup]).makeIterator()
        var currentGroup = groupStream.next()
        
        var transactionStream = allData.makeIterator()
        var currentTransaction = transactionStream.next()
        
        var minGroup = determineMinGroup( group: currentGroup, transaction: currentTransaction )

        var grandTotal = 0.0
        while let localMinGroup = minGroup {
            
            output.appendHeader(group: localMinGroup)
            
            if (currentTransaction == nil) || (localMinGroup != currentTransaction!.group) {
                output.appendNotFoundMessage( group: localMinGroup)
            }
            else {
            
                var total = 0.0
                while let localCurrentTransaction = currentTransaction, localCurrentTransaction.group == localMinGroup {
                    
                    let currentDate = localCurrentTransaction.date
                    output.appendSubheader(date: currentDate)
                    
                    while let localCurrentTransaction = currentTransaction, (localCurrentTransaction.group == localMinGroup) && (localCurrentTransaction.date == currentDate) {
                        
                        let amount = localCurrentTransaction.amount
                        total += amount
                        grandTotal += amount
                        output.appendDetail(description: localCurrentTransaction.description, amount: amount)
                        
                        currentTransaction = transactionStream.next()
                    }
                    output.appendSubfooter()
                }
                output.appendFooter(total: total)
            }
            currentGroup = groupStream.next()
            minGroup = determineMinGroup( group: currentGroup, transaction: currentTransaction )
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
