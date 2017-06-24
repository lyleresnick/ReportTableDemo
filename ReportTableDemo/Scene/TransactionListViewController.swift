//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var adapter: TransactionListAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformFromTwoSources()
    }
    
    func transformFromTwoSources() {
        
        let transformer = TransactionListTwoSourceTransformer(
            authorizedTransactions: TransactionModel.authorizedTransactions,
            postedTransactions: TransactionModel.postedTransactions)
        transformer.transform( output: adapter )
    }
    
    func transformFromOneSource() {
        
        let transformer = TransactionListOneSourceTransformer(allTransactions: TransactionModel.allTransactions)
        transformer.transform(output: adapter)

    }
}

