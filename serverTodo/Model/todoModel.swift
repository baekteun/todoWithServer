//
//  todoModel.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Foundation

struct todoModel: Codable{
    var _id: Int
    var 할일: String
    var 날짜: String
    var 제목: String
    init(dict: [String:Any]){
        self._id = dict["_id"] as? Int ?? 0
        self.할일 = dict["할일"] as? String ?? ""
        self.날짜 = dict["날짜"] as? String ?? ""
        self.제목 = dict["제목"] as? String ?? ""
    }
    init(할일: String, 날짜: String, 제목: String){
        self._id = 0
        self.할일 = 할일
        self.날짜 = 날짜
        self.제목 = 제목
    }
}
