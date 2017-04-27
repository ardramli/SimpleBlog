//
//  DetailViewController.swift
//  SImpleBlog
//
//  Created by ardMac on 27/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.layer.borderWidth = 0.2
            textView.layer.cornerRadius = 5
            textView.layer.masksToBounds = true
        }
    }

    var selectedBlog : Blog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
                // Do any additional setup after loading the view.
    }
    
    func setupData() {
        if self.selectedBlog == nil {
            return
        }
        
        else {
            textField.text = selectedBlog.title
            textView.text = selectedBlog.body
        }
    }
    
    func convertToDictionary() -> [String : String]{
        var dict : [String : String] = [:]
        guard let title = textField.text,
              let body = textView.text
        else{return [:]}
        dict["title"] = title
        dict["body"] = body
        
        return dict
    }
        
    @IBAction func doneButtonTapped(_ sender: Any) {
        if self.selectedBlog == nil {
            let dictionary : [String:Any] = ["blog" : convertToDictionary()]
            BlogApi.postABlog(dictionary: dictionary)
            navigationController?.popViewController(animated: true)
            return
        }else{
            let dictionary : [String:Any] = ["blog" : convertToDictionary()]
            BlogApi.updateABlog(dictionary: dictionary, id: selectedBlog.blogID)
        }
        
        navigationController?.popViewController(animated: true)
    }

}
