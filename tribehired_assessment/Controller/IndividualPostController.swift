//
//  IndividualPostController.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 04/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class IndividualPostController: UIViewController , NVActivityIndicatorViewable{
    
    //MARK:- properties
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var imgIndividu: UIImageView!
    @IBOutlet weak var lblTitleIndividual: UILabel!
    @IBOutlet weak var lblBodyIndividual: UILabel!
    @IBOutlet weak var tblComment: UITableView!
    @IBOutlet weak var constrainHeightTbl: NSLayoutConstraint!
    
    //MARK:- variable
    var userId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getIndividualPost()
        configureView()
        
    }
    
    
    func configureView() {
        
        viewSearch.borderRadiusView(border: 0.5, radius: 20, color: .darkGray)
        
        tblComment.delegate = self
        tblComment.dataSource = self
        
        tblComment.estimatedRowHeight = 200
        tblComment.rowHeight = UITableView.automaticDimension
        
        txtSearch.delegate = self
        txtSearch.returnKeyType = .search
        
    }
    
    func displayIndividualPost() {
        
        if individualpostDetail != nil {
            lblTitleIndividual.text = individualpostDetail.title
            lblBodyIndividual.text = individualpostDetail.body
        }
        
    }
    
    func getIndividualPost() {
        individualpostDetail = nil
        
        let urlString = "\(Urls().WebApiPost)/\(userId)"
        print("Webservice getIndividualPost ->\(urlString)")
        
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
                let jSONData = try JSONDecoder().decode(IndividualPost.self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    // print(jSONData)
                    
                    //if JSON has value
                    individualpostDetail = jSONData
                    self.displayIndividualPost()
                    self.getComment()
                    //stop loader
                    // self.stopAnimating()
                }
                
            } catch let jsonError {
                print(jsonError)
                
                //stop loader
                //self.stopAnimating()
            }
        }.resume()
    }
    
    func getComment() {
        listCommentPost.removeAll()
        tmpListCommentPost.removeAll()
        
        let urlString = "\(Urls().WebApiComment)?postId=\(userId)"
        print("Webservice getComment ->\(urlString)")
        
        //remove spacing
        let urlNoPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlNoPercent) else { return }
        
        //start loader
        // self.startAnimating()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jSONData = try JSONDecoder().decode([CommentPost].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print(jSONData)
                    
                    //if JSON has value
                    listCommentPost = jSONData
                    tmpListCommentPost = listCommentPost
                    self.tblComment.reloadData()
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

extension IndividualPostController : UITableViewDelegate, UITableViewDataSource {
    
    //Display row in tableivew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCommentPost.count
    }
    
    //Display data in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblComment.dequeueReusableCell(withIdentifier: "idindividuposttblcell", for: indexPath) as! IndividuPostTblCell
        
        let item : CommentPost = listCommentPost[indexPath.row]
        cell.lblTitle.text = item.name
        cell.lblBody.text = item.body
        cell.lblEmail.text = item.email
        
        cell.imgPerson.borderRadiusView(border: 0.5, radius: 25, color: .darkGray)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        constrainHeightTbl.constant = tblComment.contentSize.height
        self.tblComment.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 0.00001
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension IndividualPostController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let strText = textField.text!
        if strText == "" {
            listCommentPost = tmpListCommentPost
        }else {
            if tmpListCommentPost.count > 0 {
                listCommentPost.removeAll()
                for item in tmpListCommentPost {
                    if item.body!.contains(strText) {
                        listCommentPost.append(item)
                    }else if item.name!.contains(strText) {
                        listCommentPost.append(item)
                    }else if item.email!.contains(strText){
                        listCommentPost.append(item)
                    }
                }
            }
        }
        
        if listCommentPost.count == 0 {
           constrainHeightTbl.constant = 1
            
        }
        
        tblComment.reloadData()
        view.endEditing(true)
        return true
    }
}
