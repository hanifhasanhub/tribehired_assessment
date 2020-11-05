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
        getListAllPost()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
                super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func configureView() {
        
        //Delegate tableview
        tblAllPost.delegate = self
        tblAllPost.dataSource = self
    }
    
    func getListAllPost() {
        //Start Place holder
        self.startAnimating()
        
        Webservice().fetchAllPost { (AllPost) in
            listAllPost = AllPost
            DispatchQueue.main.async {
                self.tblAllPost.reloadData()
                //Stop loader
                self.stopAnimating()
            }
        }
    }
    
    //Pass data to other controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueindividupost" {
            let destinationVC = segue.destination as! IndividualPostController
            destinationVC.userId = userId
        }
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
    
    //Select specific row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item : AllPost = listAllPost[indexPath.row]
        userId = item.id!
        performSegue(withIdentifier: "segueindividupost", sender: self)
    }
    
    //Table view cell amnimation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.03,
            delay: 0.03 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
}
