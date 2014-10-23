//
//  ViewController.swift
//  Clueless
//
//  Created by Willem van der Schyff on 2014/10/21.
//  Copyright (c) 2014 Willem van der Schyff. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var results = [AnyObject]()

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        if results.count >= indexPath.row {
            let area = results[indexPath.row]["area"] as String
            let suburb = results[indexPath.row]["suburb"] as String
            cell.textLabel?.text = "\(suburb)"
            cell.detailTextLabel?.text = "\(area)"
        }
        return cell
    }

    @IBAction func findClick(sender: UIButton) {
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        let searchQuery = searchTextField.text
        var request = NSMutableURLRequest(URL: NSURL(string: "http://poco.cloudapp.net/api/locations/?search=\(searchQuery)"))
        var response:NSURLResponse?
        var error:NSError?
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var jsonError: NSError?
            self.results = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &jsonError) as [AnyObject]
            self.searchResultTableView.reloadData()
            self.loadingIndicator.alpha = 0
            self.loadingIndicator.stopAnimating()
        })
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

