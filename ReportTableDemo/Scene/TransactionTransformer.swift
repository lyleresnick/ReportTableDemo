//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionTransformer {
    
    private let output: TransactionTransformerOutput
    
    init( output: TransactionTransformerOutput ) {
        self.output = output
    }
    
    func transform(data: TransactionViewModelIterator, group: TransactionViewModel.Group ) {
        
        let transactionStream = data.makeIterator()
        var currentTransaction = transactionStream.next()
        
        output.appendHeader(title: group.toString())
        
        if currentTransaction == nil {
            
            output.appendMessage( message: "\(group.rawValue) Transactions are not currently available. You might want to call us and tell us what you think of that!")
            return
        }
        
        let transactionReport = TransactionReportViewModel()
        
        while let localCurrentTransaction = currentTransaction {
            
            let currentDate = localCurrentTransaction.date
            output.appendSubheader(date: currentDate)
            
            while let localCurrentTransaction = currentTransaction, localCurrentTransaction.date == currentDate {
                
                localCurrentTransaction.addAmountToReport(reportModel: transactionReport)
                output.appendDetail(description: localCurrentTransaction.description, amount: localCurrentTransaction.amount)
                currentTransaction = transactionStream.next()
            }
            output.appendSubfooter()
        }
        output.appendFooter(total: transactionReport.total)
    }
}
