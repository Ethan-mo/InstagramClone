//
//  MainTabController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/12.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    // MARK: - Properties
    private var user: User? {
        didSet{
            guard let user = user else { return }
            configureViewControllers(withUser: user)
            configureTabBar()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser() // 이미 로그인 되어있는 계정이 있었을 경우를 대비하여 진행하는 fetchUser()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    // MARK: - API
    func fetchUser() {
        UserService.fetchUser { user in
            print("유저 정보가 갱신되었습니다.")
            self.user = user
        }
    }
    // MARK: - Helper
    func configureViewControllers(withUser user: User) {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feed.delegate = self
        let nav1 = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: feed)
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        
        
        let profile = ProfileController(user: user)
        let nav4 = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profile)
        
        viewControllers = [nav1, search, imageSelector, notifications, nav4]
    }
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            authenticateUserAndConfigureUI()
        }
    }
    func authenticateUserAndConfigureUI() {
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
        }
    }
        
    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UIApplication.shared.statusBarStyle = .lightContent
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}

extension MainTabController: FeedControllerDelegate {
    func didRequestLogout() {
        print("Delegate 실행합니다.")
        if Auth.auth().currentUser == nil {
            print("정상적으로 로그아웃이 된 것이 확인되었습니다.")
            authenticateUserAndConfigureUI()
        }
    }
}
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()// 로그인, 계정등록 과정이 끝난 후에 진행한다. 데이터를 가져온다.
        self.dismiss(animated: true) // mainTabController에 띄워진 로그인뷰를 지운다는 의미.
    }
}
