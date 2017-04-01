//  Copyright © 2017 Lyle Resnick. All rights reserved.

protocol TransactionListTransformerOutput {
    
    func appendHeader( title: String)
    func appendSubheader( date: String )
    func appendDetail( description: String, amount: String)
    func appendSubfooter()
    func appendFooter( total: String)
    func appendMessage( message: String)
}
