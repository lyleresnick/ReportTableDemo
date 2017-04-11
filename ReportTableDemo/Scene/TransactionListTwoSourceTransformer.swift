//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListTwoSourceTransformer {

    private let authorizedData: [TransactionModel]
    private let postedData: [TransactionModel]

    init( authorizedData: [TransactionModel], postedData: [TransactionModel] ) {
        self.authorizedData = authorizedData
        self.postedData = postedData
    }

    func transform(output: TransactionListTransformerOutput) {

        var grandTotal = 0.0
        grandTotal += transform( data: authorizedData, group: .Authorized, output: output)
        grandTotal += transform( data: postedData, group: .Posted, output: output )
        output.appendGrandFooter(grandTotal: grandTotal)
    }

    
    private func transform(data: [TransactionModel], group: TransactionGroup, output: TransactionListTransformerOutput ) -> Double {
        
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
