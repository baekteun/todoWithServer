//
//  API.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Alamofire
import Foundation
import SwiftyJSON

class API{
    static let baseUrl = "http://10.120.74.32:3000"
    static func getTodoList(completion: @escaping([todoModel]) -> Void){
        AF.request("\(API.baseUrl)/list", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { res in
            switch res.result{
            case .success(_):
                var todos: [todoModel] = []
                let json = JSON(res.data!).array!
                for i in 0..<json.count{
                    let todo = todoModel(dict: json[i].dictionaryObject!)
                    todos.append(todo)
                }
                completion(todos)
            case .failure(let err):
                print(err.localizedDescription)
                
            }
        }
    }
    static func createTodo(_ todoModel: todoModel, delegate: addTodoDelegate){
        let param: [String:String] = [
            "date" : todoModel.날짜,
            "title" : todoModel.제목
        ]
        AF.request("\(API.baseUrl)/add",
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default)
            .responseString { res in
                switch res.result{
                case .success(_):
                    print(res.value)
                    delegate.didFinishAdd()
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
    static func deleteTodo(_ todoModel: todoModel){
        let param: [String:Int] = [
            "_id" : todoModel._id
        ]
        
        AF.request("\(API.baseUrl)/delete",
                   method: .delete,
                   parameters: param,
                   encoding: JSONEncoding.default)
            .responseJSON { res in
                switch res.result{
                case .success(_):
                    let json = JSON(res.data!)
                    let response = responseModel(message: json["message"].rawValue as! String)
                    print(response.message)
                case .failure(let err):
                    print(err.localizedDescription)
                }
                
                
            }
    }
    static func updateTodo(_ todoModel: todoModel){
        let param: [String:Any] = [
            "id" : todoModel._id,
            "title" : todoModel.제목,
            "date" : todoModel.할일
        ]
        AF.request("\(API.baseUrl)/edit",
                   method: .put,
                   parameters: param,
                   encoding: JSONEncoding.default)
            .responseJSON { res in
                switch res.result{
                case .success(_):
                    print(res.data!)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
}
