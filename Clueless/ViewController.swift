//
//  ViewController.swift
//  Clueless
//
//  Created by Willem van der Schyff on 2014/10/21.
//  Copyright (c) 2014 Willem van der Schyff. All rights reserved.
//

import UIKit

class PocoItem {
    var id: String?
    var suburb: String?
    var area: String?
    var postal: String?
    var street: String?
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!

    var results = [AnyObject]()

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        if results.count >= indexPath.row {
            let area = results[indexPath.row]["area"] as String
            let suburb = results[indexPath.row]["suburb"] as String
            cell.textLabel?.text = "\(area)"
            cell.detailTextLabel?.text = "\(suburb)"
        }
        return cell
    }

    @IBAction func findClick(sender: UIButton) {
        let searchQuery = searchTextField.text
        var request = NSMutableURLRequest(URL: NSURL(string: "http://poco.cloudapp.net/api/locations/?search=\(searchQuery)"))
        var response:NSURLResponse?
        var error:NSError?

        let result:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        let httpResponse:NSHTTPURLResponse? = response as? NSHTTPURLResponse

        var datastring = NSString(data: result!, encoding: NSUTF8StringEncoding)
        searchResultLabel.text = datastring

        var jsonError: NSError?
        results = NSJSONSerialization.JSONObjectWithData(result!, options: nil, error: &jsonError) as [AnyObject]
        searchResultTableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

