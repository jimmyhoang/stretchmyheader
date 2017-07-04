//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Jimmy Hoang on 2017-07-04.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{

    var detailViewController: DetailViewController? = nil
    var newsItems = [NewsItem(category: "World", description: "Climate change protests, divestments meet fossil fuels realities", colour: UIColor.red),
                     NewsItem(category: "Europe", description: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime", colour: UIColor.green),
                     NewsItem(category: "Middle East", description: "Airstrikes boost Islamic State, FBI director warns more hostages possible", colour: UIColor.yellow),
                     NewsItem(category: "Africa", description: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim", colour: UIColor.orange),
                     NewsItem(category: "Asia Pacific", description: "Despite UN ruling, Japan seeks backing for whale hunting", colour: UIColor.purple),
                     NewsItem(category: "Americas", description: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria", colour: UIColor.blue),
                     NewsItem(category: "World", description: "South Africa in $40 billion deal for Russian nuclear reactors", colour: UIColor.red),
                     NewsItem(category: "Europe", description: "One million babies' created by EU student exchanges", colour: UIColor.green)
                    ]
    var headerView: UIView!
    let kTableHeaderHeight: CGFloat = 300.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.estimatedRowHeight = 63.0
        tableView.rowHeight = UITableViewAutomaticDimension

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 300.0))
        
        let imageView                      = UIImageView(frame: headerView.frame)
        imageView.contentMode              = .scaleAspectFill
        imageView.image                    = #imageLiteral(resourceName: "bg-header")
        imageView.isUserInteractionEnabled = true
        headerView.addSubview(imageView)
        
        let dateLabel = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 20))
        let date      = Date()
        
        let dateFormatter        = DateFormatter()
        dateFormatter.dateStyle  = .medium
        dateFormatter.timeStyle  = .none
        dateFormatter.dateFormat = "MMMM dd"
        dateFormatter.locale     = Locale(identifier: "en_CA")
        
        
        dateLabel.text      = dateFormatter.string(from: date)
        dateLabel.textColor = UIColor.white
        imageView.addSubview(dateLabel)
        
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        tableView.contentInset  = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = newsItems[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let item = newsItems[indexPath.row]
        cell.headlineLabel.numberOfLines = 0

        cell.categoryLabel.textColor       = item.colour
        cell.categoryLabel.text            = item.category
        cell.headlineLabel.text            = item.description
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //MARK: Helpers
    
    func updateHeaderView() {
        var headerReact = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerReact.origin.y = tableView.contentOffset.y
            headerReact.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerReact
    }
    
    //MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }

}

