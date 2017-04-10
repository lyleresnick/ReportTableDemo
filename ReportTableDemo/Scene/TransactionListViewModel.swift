//  Copyright © 2017 Lyle Resnick. All rights reserved.

class TransactionListViewModel {
    
    private var totalDouble = 0.0
    private var grandTotalDouble = 0.0
    
    var total: String { return String( format: "%.2f", totalDouble) }
    var grandTotal: String { return String( format: "%.2f", totalDouble) }

    
    func add(amount: Double) {
        totalDouble += amount
        grandTotalDouble += amount
    }
}
