//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adapter: TransactionListAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformFromTwoSources()
    }
    
    func transformFromTwoSources() {
        
        let transformer = TransactionListTwoSourceTransformer( output: adapter )
        var grandTotal = 0.0
        grandTotal += transformer.transform( data: TransactionModel.authorizedData, group: .Authorized )
        grandTotal += transformer.transform( data: TransactionModel.postedData, group: .Posted )
        adapter.appendGrandFooter(grandTotal: grandTotal)

    }
    
    func transformFromOneSource() {
        
        let transformer = TransactionListOneSourceTransformer( output: adapter )
        transformer.transform( data: TransactionModel.allData)

    }
}

