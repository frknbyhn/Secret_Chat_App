//
//  Constants.swift
//  Calculator
//
//  Created by Furkan Beyhan on 4.04.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
