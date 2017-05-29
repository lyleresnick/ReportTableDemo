//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

protocol TransactionListTransformerOutput {
    
    func appendHeader(group: TransactionGroup)
    func appendSubheader(date: Date )
    func appendDetail(description: String, amount: Double)
    func appendSubfooter()
    func appendFooter(total: Double)
    func appendGrandFooter(grandTotal: Double)
    func appendNotFoundMessage(group: TransactionGroup)
    func appendNoTransactionsMessage(group: TransactionGroup)
    
    func appendNotFoundMessage()
}
