//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

public class ErrorModel: Error {
    
    var messageKey: String
    var message: String {
        return ""//messageKey.localized()
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions

public extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}
