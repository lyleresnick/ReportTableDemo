//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

struct TransactionViewModel {

    let group: Group
    let date: String
    let description: String
    let amount: String

    enum Group: String {
        case Authorized = "A"
        case Posted = "P"
        
        func toString() -> String {
            switch self {
            case .Authorized:
                return "Authorized"
            case .Posted:
                return "Posted"
            }
        }

    }
    
    static let groupList: [Group] = [.Authorized, .Posted]
    
    private static func dateFormat(format: String ) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
    
    private static let inboundDateFormat = TransactionViewModel.dateFormat( format: "yyyy'-'MM'-'dd" )
    private static let outboundDateFormat = TransactionViewModel.dateFormat( format: "MMM' 'dd', 'yyyy" )
    
    init?( transaction: TransactionModel? ) {
        
        guard let transaction = transaction else { return nil }
        
        guard let group = Group(rawValue: transaction.group) else {
            fatalError("Format of Group is incorrect")
        }
        self.group = group

        description = transaction.description
        
        var sign: String!
        switch transaction.debit
        {
        case "D":
            sign = ""
        case "C":
            sign = "-"
        default:
            fatalError("Format of Transaction Sign is incorrect")
        }
        amount = sign + transaction.amount
        
        guard let dateAsDate = TransactionViewModel.inboundDateFormat.date( from: transaction.date )
        else {
            fatalError("Format of Transaction Date is incorrect")
        }
        date = TransactionViewModel.outboundDateFormat.string(from: dateAsDate)
    }
    
    func addAmountToReport(reportModel: TransactionReportViewModel )  {
        reportModel.add(amount: Double( amount )!)
    }
    
}
