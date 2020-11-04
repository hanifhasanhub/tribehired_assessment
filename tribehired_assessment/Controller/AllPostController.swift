//
//  AllPostController.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 04/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AllPostController: UIViewController, NVActivityIndicatorViewable {
    
    
    //MARK: - properties
    @IBOutlet weak var tblAllPost: UITableView!
    
    
    //MARK:- variable
    var userId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        getAllPost()
    }
    
    func configureView() {
        //Delegate tableview
        tblAllPost.delegate = self
        tblAllPost.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueindividupost" {
            let destinationVC = segue.destination as! IndividualPostController
            destinationVC.userId = userId
        }
    }
    
    func getAllPost() {
        listAllPost.removeAll()
        
        let urlString = "\(Urls().WebApiPost)"
        print("Webservice getAllPost ->\(urlString)")
        
        //remove spacing
        let urlNoPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlNoPercent) else { return }
        
        //start loader
        self.startAnimating()
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jSONData = try JSONDecoder().decode([AllPost].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    print(jSONData)
                    
                    //if JSON has value
                    listAllPost = jSONData
                    
                    self.tblAllPost.reloadData()
                    //stop loader
                    self.stopAnimating()
                    
                    
                }
                
            } catch let jsonError {
                print(jsonError)
                
                //stop loader
                //self.stopAnimating()
            }
        }.resume()
    }
    
    
}

extension AllPostController : UITableViewDelegate, UITableViewDataSource {
    
    //Display row in tableivew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAllPost.count
    }
    
    //Display data in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAllPost.dequeueReusableCell(withIdentifier: "idallposttblcell", for: indexPath) as! AllPostTblCell
        
        let item : AllPost = listAllPost[indexPath.row]
        cell.lblTitle.text = item.title
        cell.lblBody.text = item.body
        
        cell.viewContent.borderRadiusView(border: 0.5, radius: 20, color: .darkGray)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item : AllPost = listAllPost[indexPath.row]
        userId = item.id!
        performSegue(withIdentifier: "segueindividupost", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.05,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
}
