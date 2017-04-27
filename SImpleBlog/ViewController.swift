//
//  ViewController.swift
//  SImpleBlog
//
//  Created by ardMac on 27/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.register(BlogCell.cellNib, forCellReuseIdentifier: BlogCell.cellIdentifier)
            
            tableView.estimatedRowHeight = CGFloat(64.0)
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    var blogs : [Blog] = []
    @IBOutlet weak var newBlogButton: UIBarButtonItem! {
        didSet{
            newBlogButton.target = self
            newBlogButton.action = #selector(newBlogButtonTapped)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        BlogApi.getAllBlogs { (blogs, error) in
            if let validError = error {
                print(validError)
                return
            }
            
            self.blogs = blogs
            self.tableView.reloadData()
            
        }
    }
    
    func newBlogButtonTapped(){
        let storyboard = UIStoryboard (name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogCell.cellIdentifier) as? BlogCell
            else {return UITableViewCell()}
        return configured(blogCell: cell, withBlog: blogs[indexPath.row])
    }
    
    func configured( blogCell: BlogCell, withBlog blog: Blog) -> BlogCell {
        blogCell.titleLabel.text = blog.title
        blogCell.bodyLabel.text = blog.body
        
        return blogCell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.navigationItem.title = blogs[indexPath.row].title
            vc.selectedBlog = blogs[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedBlogID = blogs[indexPath.row].blogID
            BlogApi.deleteABlog(id: deletedBlogID, completion: { (error) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.blogs.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            })
        }
        
        
    }
    
    
}
