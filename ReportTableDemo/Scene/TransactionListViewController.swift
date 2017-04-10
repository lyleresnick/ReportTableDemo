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
        transformer.transform( data: TransactionModel.authorizedData, group: .Authorized )
        transformer.transform( data: TransactionModel.postedData, group: .Posted )
    }
    
    func transformFromOneSource() {
        
        let transformer = TransactionListOneSourceTransformer( output: adapter )
        transformer.transform( data: TransactionModel.allData, groupList: TransactionGroup.groupList)

    }
}

