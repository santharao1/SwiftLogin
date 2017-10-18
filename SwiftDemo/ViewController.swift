//
//  ViewController.swift
//  SwiftDemo
//
//  Created by apple on 16/08/17.
//  Copyright © 2017 Santharao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel!.text = self.items[indexPath.row]
        cell.backgroundColor = UIColor.yellow
        
        return cell
    }
   
    
    @IBOutlet var tableView: UITableView!
   // var items: [String] = ["We", "Heart", "Swift","2","3","4"]
    
    var items =  [String]()
    override func viewWillAppear(_ animated: Bool) {
        let myDefults = UserDefaults()
        if myDefults.value(forKey: "userName") != nil { //Returns the integer value associated with the specified key.
            items .append(myDefults.value(forKey: "userName") as! String)
            self.tableView.reloadData()
        } else {
            //no highscore exists
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toy = items[indexPath.row]
        print(toy)
        
//        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        self.navigationController!.pushViewController(vc, animated: true)
        
       // let rvc: LoginViewController = LoginViewController()
       // self.navigationController!.pushViewController(rvc, animated: true)
        
        
        let mapView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(mapView, animated: true)

        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

