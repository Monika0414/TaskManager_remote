//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Monika on 07/04/23.
//

import SwiftUI
// Instance of a task
final class Task: Identifiable, Hashable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.description == rhs.description && lhs.isCompleted == rhs.isCompleted
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(id)
        hasher.combine(isCompleted)
    }
 @Published var isCompleted:Bool
    var id = UUID().uuidString
    var title:String
    var description:String
    
    
    init( title: String, description: String, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}

final class TaskStore:ObservableObject{
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
