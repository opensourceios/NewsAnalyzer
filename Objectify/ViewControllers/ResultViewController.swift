//
//  ResultViewController.swift
//  Objectify
//
//  Created by ehsan sat on 3/23/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// entities table view

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {

    var items: [Item] = []
    
    var entities: [Item] = []
    
    var initialCell: [Bool] = []
    
    @IBOutlet weak var chartsButton: UIBarButtonItem!
    
    @IBOutlet weak var entitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillEntities()
        
        self.view.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        
        entitiesTableView.delegate = self
        entitiesTableView.dataSource = self
        tabBarController?.delegate = self
        
        entitiesTableView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        
        entitiesTableView.sectionHeaderHeight = 20 
        entitiesTableView.rowHeight = UITableView.automaticDimension
        entitiesTableView.estimatedRowHeight = 40
        entitiesTableView.separatorStyle = .none
        
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir", size: 16)!], for: .normal)
        self.tabBarController?.tabBarItem.image = #imageLiteral(resourceName: "Image")
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.7242990732, green: 0.7850584388, blue: 0.9598841071, alpha: 1)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chartsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToEntitiesCharts", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entitiesCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        if initialCell[indexPath.section] == true {
            if self.entities[indexPath.section].sentimentResult == "positive" {
                cell.backgroundColor = #colorLiteral(red: 0.2040559649, green: 0.7372421622, blue: 0.6007294059, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if self.entities[indexPath.section].sentimentResult == "neutral" {
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else if self.entities[indexPath.section].sentimentResult == "negative" {
                cell.backgroundColor = #colorLiteral(red: 0.920953393, green: 0.447560966, blue: 0.4741248488, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            if indexPath.row == 0 {
                cell.textLabel?.text = self.entities[indexPath.section].text
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.layer.cornerRadius = 20
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Sentiment: " + " \(self.entities[indexPath.section].sentimentResult) " + " \n Value: " + " \(self.entities[indexPath.section].sentimentPolarity)" + String(format: "%.3f", self.entities[indexPath.section].sentimentValue)
                cell.textLabel?.textAlignment = .center
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Magnitude: \(String(format: "%.3f", self.entities[indexPath.section].magnitude))"
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 20
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = self.entities[indexPath.section].sentenceText
                cell.textLabel?.textAlignment = .center
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.layer.cornerRadius = 20
            } else if indexPath.row == 1 {
                cell.textLabel?.text = ""
                cell.textLabel?.numberOfLines = 0
            } else if indexPath.row == 2 {
                cell.textLabel?.text = ""
                cell.textLabel?.numberOfLines = 0 
                cell.clipsToBounds = true
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.layer.cornerRadius = 20
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        initialCell[indexPath.section] = !initialCell[indexPath.section]
        tableView.reloadData()
    }
    
    func fillEntities () {
        if self.items.count != 0 {
            for item in items {
                if item.sentencePartType == "entity" {
                    entities.append(item)
                    let inital = true
                    initialCell.append(inital)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEntitiesCharts" {
            let vc = segue.destination as! EntitiesChartsViewController
            vc.entities = entities
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   

}
