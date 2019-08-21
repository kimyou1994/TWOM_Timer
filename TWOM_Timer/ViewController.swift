//
//  ViewController.swift
//  TWOM_Timer
//
//  Created by Young Kim on 6/25/19.
//  Copyright © 2019 Young Jin Kim. All rights reserved.
//
import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var monsters:[Monster] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        tableView.backgroundColor = UIColor.lightGray
        monsters = Monster.createMonsterArray()
        setupNavBar()
    }
    //set up navigation bar
    func setupNavBar() {
        //background
//       navigationController?.navigationBar.barTintColor = UIColor.lightGray
       navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white,
                                                                   .font : UIFont.init(name: "MarkerFelt-Wide", size: 40.0)!]
//
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Nav-Background").resizableImage(withCapInsets:  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch), for: .default)
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        //create search bar
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = true
    }

}

//extensions for table view
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let monster = monsters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonsterCell") as! MonsterCell
        cell.displayMonster(monster: monster)
        cell.backgroundColor = monster.color
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reset = UIContextualAction(style: .normal, title: "Reset") { (action, view, nil) in
            print("reset")
        }
        reset.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        let config = UISwipeActionsConfiguration(actions: [reset])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reset = UIContextualAction(style: .destructive, title: "Reset") { (action, view, success) in
            let cell = tableView.cellForRow(at: indexPath) as! MonsterCell
            cell.resetTimer()
            success(false)
        }
        reset.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        reset.image = #imageLiteral(resourceName: "reset-40")
        let config = UISwipeActionsConfiguration(actions: [reset])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let monster = monsters[indexPath.row]
//        performSegue(withIdentifier: "MasterToDetail", sender: video)
//    }
}

