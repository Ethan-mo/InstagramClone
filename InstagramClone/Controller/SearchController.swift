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
    var searchController: UISearchController!
    
    var users = [User]() {
        didSet{
            tableView.reloadData()
        }
    }
    var filterUsers = [User]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
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
        configureSearchController()
        fetchUsers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }
    // MARK: - API
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.filterUsers = users
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
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.title = "사용자 검색"
        searchController.searchBar.placeholder = "사용자 이름"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false

        searchController.hidesNavigationBarDuringPresentation = false
    }
}
// MARK: - UITableViewDatasource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? filterUsers.count : users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.userCellViewModel = UserCellViewModel(user: user)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 70
        return height
    }
}
// MARK: - UITableViewDelegate
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SearchController에서 user: \(users[indexPath.row].nickname)의 정보를 불러와 새로운 ProfileController를 엽니다.")
        let controller = ProfileController(user: users[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filterUsers = users.filter { $0.nickname.contains(searchText) || $0.fullname.contains(searchText)}
        
    }
        // 검색 중인지 확인하는 함수
        func isFiltering() -> Bool {
            return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        }
}
