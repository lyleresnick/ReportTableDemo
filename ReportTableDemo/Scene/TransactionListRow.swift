//  Copyright © 2017 Cellarpoint. All rights reserved.

enum TransactionListRow {

    case header( title: String )
    case subheader( title: String, odd: Bool )
    case detail( description: String, amount: String, odd: Bool )
    case subfooter( odd : Bool )
    case footer( total: String, odd: Bool )
    case grandfooter(total: String )
    case message( message: String )
}
