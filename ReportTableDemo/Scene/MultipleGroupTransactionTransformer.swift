//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class MultipleGroupTransactionTransformer {
    
    fileprivate let output: TransactionTransformerOutput
    
    init( output: TransactionTransformerOutput ) {
        self.output = output
    }
    
    func transform(data transactionStream: TransactionViewModelIterator, groupList: [TransactionViewModel.Group]) {
        
        var groupStream = groupList.makeIterator()
        var currentGroup = groupStream.next()
        
        var currentTransaction = transactionStream.next()
        
        var minGroup = determineMinGroup( group: currentGroup, transaction: currentTransaction )

        while let localMinGroup = minGroup {
            
            output.appendHeader(title: localMinGroup.toString())
            
            if (currentTransaction == nil) || (localMinGroup != currentTransaction!.group) {
                
                output.appendMessage( message: "\(localMinGroup.toString()) Transactions are not currently Available. You might want to call us and tell us what you think of that!")
            }
            else {
            
                let transactionReport = TransactionReportViewModel()
                while let localCurrentTransaction = currentTransaction, localCurrentTransaction.group == localMinGroup {
                    
                    let currentDate = localCurrentTransaction.date
                    output.appendSubheader(date: currentDate)
                    
                    while let localCurrentTransaction = currentTransaction, (localCurrentTransaction.group == localMinGroup) && (localCurrentTransaction.date == currentDate) {
                        
                        localCurrentTransaction.addAmountToReport(reportModel: transactionReport)
                        output.appendDetail(description: localCurrentTransaction.description, amount: localCurrentTransaction.amount)
                        
                        currentTransaction = transactionStream.next()
                    }
                    output.appendSubfooter()
                }
                output.appendFooter(total: transactionReport.total)
            }
            currentGroup = groupStream.next()
            minGroup = determineMinGroup( group: currentGroup, transaction: currentTransaction )
        }
    }
    
    func determineMinGroup(group: TransactionViewModel.Group?, transaction: TransactionViewModel?) -> TransactionViewModel.Group? {
        
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
