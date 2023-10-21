//
//  Menus.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 21/10/2023.
//

import SwiftUI

struct Menus: Commands {
    var body: some Commands {
        SidebarCommands()
        ToolbarCommands()
    }
}
