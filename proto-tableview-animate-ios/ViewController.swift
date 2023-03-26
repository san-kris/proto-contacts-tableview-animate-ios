//
//  ViewController.swift
//  proto-tableview-animate-ios
//
//  Created by Santosh Krishnamurthy on 3/24/23.
//

import UIKit

class ViewController: UITableViewController {

    let cellID = "cellID"
    
    var names = [
        ExpandableNames(isExpanded: true, names: [
            Contact(name: "Amy", isFavorite: false),
            Contact(name: "Bill", isFavorite: false),
            Contact(name: "Zack", isFavorite: false),
            Contact(name: "Rohan", isFavorite: false),
            Contact(name: "Jack", isFavorite: false)]),
        ExpandableNames(isExpanded: true, names: [
            Contact(name: "Bill", isFavorite: false),
            Contact(name: "Bob", isFavorite: false),
            Contact(name: "Basket", isFavorite: false)]),
        ExpandableNames(isExpanded: true, names: [
            Contact(name: "Cat", isFavorite: false),
            Contact(name: "Cart", isFavorite: false),
            Contact(name: "Car", isFavorite: false)])
    ]
        
    var showIndexPath = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavBar()
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellID)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        
    }
    
    @objc func handleShowIndexPath(){
        var indexPaths = [IndexPath]()
        
        for sectionIndex in names.indices{
            for rowIndex in names[sectionIndex].names.indices {
                let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                indexPaths.append(indexPath)
            }
        }

        let animationStyle = showIndexPath ? UITableView.RowAnimation.left : UITableView.RowAnimation.right
        tableView.reloadRows(at: indexPaths, with: animationStyle)
        showIndexPath = !showIndexPath
        
    }
    
    func setFavoriteContact(cell: UITableViewCell) -> Void {
        print("In VC")
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        names[indexPath.section].names[indexPath.row].isFavorite = !names[indexPath.section].names[indexPath.row].isFavorite
    }

    fileprivate func setupNavBar() {
        
        // set the title of the navigation controller
        // navigation item is the property of ViewController that is used by Navigation controller
        navigationItem.title = "Contacts"
        
        // Make title large
        // Navigation Bar is a Perperty of Navigation Controller. Nav controller only exist if view is embeded in nav controller
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Table view Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        names.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].isExpanded ? names[section].names.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactCell
        cell.link = self
        var cellConfig =  cell.defaultContentConfiguration()
        let name = names[indexPath.section].names[indexPath.row].name
        cellConfig.text = showIndexPath ? "\(name)\t Section\(indexPath.section):Row\(indexPath.row)" : "\(name)"
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // add a button to header
        let button = UIButton(type: .system)
        button.setTitle("Close", for: UIButton.State.normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.tag = section
        button.addTarget(self, action: #selector(handleSectionClose), for: UIControl.Event.touchUpInside)
        return button
        
        /*
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = .lightGray
        return label
         */
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    @objc func handleSectionClose(sender: UIButton){
        // guard let title = sender.currentTitle else {return}
        print(sender.tag)
        
        // close the section by deleting the row
        let section = sender.tag
        var indexPaths = [IndexPath]()
        for row in names[section].names.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        // save the current state
        let currectState = names[section].isExpanded
        // invert the state
        names[section].isExpanded = !names[section].isExpanded
        //
        if currectState {
            tableView.deleteRows(at: indexPaths, with: .fade)
            sender.setTitle("Open", for: .normal)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
            sender.setTitle("Close", for: .normal)
        }
        
    }
    
    //MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}

