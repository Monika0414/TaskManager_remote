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
                    ForEach(taskStore.tasks, id:\.self){ task in
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
                                            
                                            TextField("Enter new title", text: $EditTitleText)
                                                .frame(width: 200, height: 50).background(.white)
                                            TextField("Enter new description", text: $EditDescriptionText)
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
                                ZStack{
                                    Color("LightPink")
                                    VStack(alignment: .center, spacing:10){
                                        Text("Details about the task")
                                            .font(.largeTitle)
                                            .foregroundColor(.black)
                                            .lineLimit(.none)
                                        Text("\(task.description)")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                            .lineLimit(.none)
                                            .padding()
                                    }
                                }.ignoresSafeArea()
                                
                            }).foregroundColor(.indigo)
                            
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
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

// Instance of a task
class Task: Identifiable, Hashable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.description == rhs.description && lhs.isCompleted == rhs.isCompleted
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(id)
        hasher.combine(isCompleted)
    }
    var isCompleted:Bool
    var id = UUID().uuidString
    var title:String
    var description:String
    
    
    init( title: String, description: String, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}

class TaskStore:ObservableObject{
    @Published var tasks:[Task]
    
    func addTask(task:Task){
        tasks.append(task)
    }
    
    func toggleIsCompleted(task:Task){
        task.isCompleted.toggle()
        self.objectWillChange.send()
    }
    
    func deleteTask(task:Task){
        tasks.removeAll(where: {$0 == task})
    }
    func editTask(task:Task){
        
        
    }
    init(tasks: [Task]) {
        self.tasks = tasks
    }
}
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
