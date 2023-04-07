//
//  EditTaskView.swift
//  TaskManager
//
//  Created by Monika on 07/04/23.
//

import SwiftUI

//Edit task view
struct EditTaskView:View{
    @State var editTitleText:String
    @State var editDescriptionText:String
    
    var body: some View{
        VStack{
            TextField("Title", text: $editTitleText)
            TextField("Description", text: $editDescriptionText)
        }
    }
}

