//
//  todoListVC.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Foundation
import UIKit
import Then
import SnapKit

class todoListVC: baseVC{
    let tableView = UITableView().then {
        $0.rowHeight = 70
        $0.register(todoTableCell.self, forCellReuseIdentifier: todoTableCell.reuse)
    }
    
    var todoList: [todoModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        fetchTodo()
    }
    
    // MARK: - Helpers
    override func configureVC() {
        addView()
        setLayout()
        setDelegate()
        self.navigationItem.title = "TODO"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTappedAddBtn))
    }
    private func setDelegate(){
        [tableView].forEach{$0.delegate = self; $0.dataSource = self}
    }
    private func addView(){
        [tableView].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        tableView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    // MARK: - Actions
    @objc private func didTappedAddBtn(){
        let controller = addTodoVC()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    private func fetchTodo(){
        API.getTodoList { todo in
            self.todoList = todo
        }
        
    }
}

// MARK: - Extensions
extension todoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoTableCell.reuse, for: indexPath) as! todoTableCell
        cell.model = todoList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                let row = indexPath.row
                API.deleteTodo(todoList[row])
                fetchTodo()
                
                
            } else if editingStyle == .insert {
                
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let con = detailTodoVC()
        con.model = todoList[indexPath.row]
        con.delegate = self
        self.navigationController?.pushViewController(con, animated: true)
    }
}

extension todoListVC: addTodoDelegate{
    func didFinishAdd() {
        self.dismiss(animated: true, completion: nil)
        fetchTodo()
    }
}

extension todoListVC: editDelegate{
    func editDidFinish() {
        self.navigationController?.popViewController(animated: true)
        fetchTodo()
    }
}
