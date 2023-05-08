//
//  SearchController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/17.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchController: UITableViewController {
    // MARK: - Properties
    var users = [User]()
    
    // MARK: - Lifecycle
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    // MARK: - API
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            print("SearchController에 정상적으로 유저 정보들을 불러왔습니다.")
            self.tableView.reloadData()
        }
    }
    // MARK: - Helper
    func configureTableView() {
        
    }
    func configureUI() {
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .white
    }
}
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.userCellViewModel = UserCellViewModel(user: users[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 70
        return height
    }
}

