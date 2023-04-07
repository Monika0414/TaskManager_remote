//
//  ContentView.swift
//  TaskManager
//
//  Created by Monika on 06/04/23.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskStore = TaskStore(tasks: [])
    @State var EditTitleText = ""
    @State var EditDescriptionText = ""
    @State var titleText = ""
    @State var descriptionText = ""
    var editview = EditTaskView(editTitleText: "", editDescriptionText: "")
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    VStack{
                        HStack{
                            //Add task btn
                            Button(action: {
                                if(titleText != "" && descriptionText != ""){
                                    taskStore.addTask(task: .init(title: titleText, description: descriptionText, isCompleted: false))
                                    titleText = ""
                                    descriptionText = ""
                                }else{
                                    titleText = "Enter Title"
                                    descriptionText = "Enter Description"
                                }
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                        TextField("Title", text: $titleText)
                        TextField("decription", text: $descriptionText)
                    }
                    
                    //Iterating
                    ForEach(taskStore.tasks){ task in
                        VStack(alignment: .leading, spacing: 4){
                            HStack{
                                Spacer()
                                Button(action: {
                                    taskStore.deleteTask(task: task)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                                
                                NavigationLink(destination: {
                                    ZStack{
                                        Color("LightBeige")
                                        VStack{
                                            
                                            TextField("Title", text: $EditTitleText)
                                                .frame(width: 200, height: 50).background(.white)
                                            TextField("Description", text: $EditDescriptionText)
                                                .frame(width: 200, height: 50).background(.white)
                                            Button(action: {
                                                task.title = EditTitleText
                                                task.description = EditDescriptionText
                                                EditTitleText = ""
                                                EditDescriptionText = ""
                                            }, label: {
                                                Text("Confirm Changes")
                                            })
                                        }.padding()
                                    }.ignoresSafeArea()
                                }, label: {
                                    Image(systemName: "pencil")
                                })
                            }.foregroundColor(.purple)
                            Text("\(task.title)").font(.title)
                            
                            
                            Text("\(task.description)").lineLimit(0)
                            NavigationLink("View details", destination: {
                                TaskDetailView(task: task)
                                
                            }).foregroundColor(.indigo)
                            
                            // checkmark
                            Button(action: {
                                withAnimation{
                                    taskStore.toggleIsCompleted(task: task)
                                }
                            }, label: {
                                ZStack{
                                    Image(systemName: "square").resizable().frame(width: 40, height: 40)
                                    Image(systemName: task.isCompleted ? "checkmark" : "squareshape.fill").resizable().frame(width: 40, height: 40)
                                }.id(task.isCompleted)
                            }).foregroundColor(.black)
                        }   .padding()
                            .background(Rectangle()
                            .foregroundColor(.yellow)
                            .cornerRadius(20))
                    }
                }.padding()
                   // .environmentObject(taskStore)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
           // .environmentObject(TaskStore(tasks: []))
    }
}



