//
//  LoginViewController.swift
//  SwiftDemo
//
//  Created by apple on 18/08/17.
//  Copyright © 2017 Santharao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Reachability

class LoginViewController: UIViewController {
let btnLogin:UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "WELCOME"
        // Do any additional setup after loading the view.
    }
    @IBOutlet var txtUserName: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    var  myName: String? = ""
    
    
    @IBAction func btnLoginTapped(_sender : AnyObject){
        print("text value: btn tapped...")
        
        
        if Reachability.isConnectedToNetwork() == true {
            if (txtUserName.text?.isEmpty)! || (txtPassword.text?.isEmpty)! {
                let alert = UIAlertController(title: "Alert", message: "Enter data", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                
                let x:String = txtUserName.text!
                let y:String = txtPassword.text!
                
                let userNameDefault = UserDefaults.standard
                userNameDefault.set(x, forKey: "userName")
                userNameDefault.set(y, forKey: "password")
                
                let postString = ["email":x,"password":y]
                                
                let myurl = "service URL"
                //   let headers    = [ "Content-Type" : "application/json"]
                
                let headers: HTTPHeaders = ["Authorization": "sxfsdfsdfsfsfsf", "Accept": "application/json", "Content-Type" :"application/json"]
                
                Alamofire.request(myurl, method: .post, parameters: postString, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    
                    _ = UIAlertAction.self
                    var actionString: String?
                    if ((response.response) != nil)
                    {
                        print("data: %@",response.description)
                        
                        let alertViewController = UIAlertController(title: "SwiftDemo", message: response.description, preferredStyle:.alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            actionString = "OK"
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                            actionString = "Cancel"
                        }
                        
                        alertViewController.addAction(cancelAction)
                        alertViewController.addAction(okAction)
                        
                        self.present(alertViewController, animated: true, completion: nil)
                    }
                    
                }
            }
        }
        else{
            print("No Internet")
        }
    }
    public class Reachability {
        
        class func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    @IBAction func cancelTapped(sender:AnyObject){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
