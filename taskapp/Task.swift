//
//  Task.swift
//  taskapp
//
//  Created by Masamichi Ebata on 2016/05/18.
//  Copyright © 2016年 Masamichi Ebata. All rights reserved.
//

import RealmSwift

class Task: Object {
    dynamic var id = 0

    dynamic var title = ""
    
    dynamic var contents = ""

    dynamic var date = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
