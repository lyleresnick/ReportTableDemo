//  Copyright © 2017 Lyle Resnick. All rights reserved.

class TransactionReportViewModel {
    
    private var totalDouble = 0.0
    
    var total: String { return String( format: "%.2f", totalDouble) }
    
    func add(amount: Double) {
        totalDouble += amount
    }
}
