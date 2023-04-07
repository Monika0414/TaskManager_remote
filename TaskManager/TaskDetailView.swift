//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Monika on 07/04/23.
//

import SwiftUI

struct TaskDetailView:View{
    var task : Task
    var body: some View{
        ZStack{
            Color("LightPink")
            VStack(alignment: .center, spacing:10){
                Text("Details about the task")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .lineLimit(.none)
                //Task Description
                Text("\(task.description)")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .lineLimit(.none)
                    .padding()
            }
        }.ignoresSafeArea()
    }
}
