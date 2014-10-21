//
//  ViewController.swift
//  Clueless
//
//  Created by Willem van der Schyff on 2014/10/21.
//  Copyright (c) 2014 Willem van der Schyff. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!

    @IBAction func findClick(sender: UIButton) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://poco.cloudapp.net/api/locations/7/"))
        var response:NSURLResponse?
        var error:NSError?

        let result:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        let httpResponse:NSHTTPURLResponse? = response as? NSHTTPURLResponse

        var datastring = NSString(data: result!, encoding: NSUTF8StringEncoding)
        searchResultLabel.text = datastring
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

