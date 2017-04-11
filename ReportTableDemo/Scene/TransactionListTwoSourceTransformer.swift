//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListTwoSourceTransformer {
    
    private let output: TransactionListTransformerOutput
    
    init( output: TransactionListTransformerOutput ) {
        self.output = output
    }
    
    func transform(data: [TransactionModel], group: TransactionGroup ) -> Double {
        
        var transactionStream = data.makeIterator()
        var currentTransaction = transactionStream.next()
        
        output.appendHeader(group: group)
        
        if currentTransaction == nil {
            
            output.appendNotFoundMessage( group: group)
            return 0.0
        }
        
        var total = 0.0
        while let localCurrentTransaction = currentTransaction {
            
            let currentDate = localCurrentTransaction.date
            output.appendSubheader(date: currentDate)
            
            while let localCurrentTransaction = currentTransaction, localCurrentTransaction.date == currentDate {
                
                let amount = localCurrentTransaction.amount
                total += amount
                output.appendDetail(description: localCurrentTransaction.description, amount: amount)
                currentTransaction = transactionStream.next()
            }
            output.appendSubfooter()
        }
        output.appendFooter(total: total)
        return total
    }
}
