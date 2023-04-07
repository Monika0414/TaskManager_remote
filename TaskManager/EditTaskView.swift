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
                .frame(width: 200, height: 50).background(.white)
            TextField("Description", text: $editDescriptionText)
                .frame(width: 200, height: 50).background(.white)
        }
    }
}

