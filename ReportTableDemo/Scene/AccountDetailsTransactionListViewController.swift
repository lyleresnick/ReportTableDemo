//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class AccountDetailsTransactionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adapter: AccountDetailsTransactionListAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformFromTwoStreams()
    }
    
    func transformFromTwoStreams() {
        
        let transformer = TransactionTransformer( output: adapter )
        transformer.transform( data: transactionViewModelGenerator( transactions: authorizedData ), group: .Authorized )
        transformer.transform( data: transactionViewModelGenerator( transactions: postedData ), group: .Posted )
    }
    
    func transformFromOneStream() {
        
        let transformer = MultipleGroupTransactionTransformer( output: adapter )
        transformer.transform( data: transactionViewModelGenerator( transactions: allData ), groupList: TransactionViewModel.groupList)

    }
}

