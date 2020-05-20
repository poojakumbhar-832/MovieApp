//
//  FirstViewController.swift
//  MovieApp 2
//
//  Created by Pooja kumbhar on 19/05/20.
//  Copyright © 2020 Pooja kumbhar. All rights reserved.
//

import UIKit
import Alamofire

class NowPlayingViewController: UIViewController{

    @IBOutlet weak var NowPlayingCollectionView: UICollectionView!
    let CellID = "NowPlayingCollectionViewCell"
    var movies = [result]()
    var posterUrl = "https://image.tmdb.org/t/p/w342"
    var backDropMainUrl = "https://image.tmdb.org/t/p/original"
    var backDropUrl = ""
    var searchBar = UISearchBar()
    var searchArray = [result]()
    var searchFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        NowPlayingCollectionView.delegate = self
        NowPlayingCollectionView.dataSource = self
        registerNib()
        createSearchBar()
        let service = Service(baseUrl:"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        service.getCountryNameFrom()
        service.completionHandler {[weak self] (movies, status, message) in
            if status{
                guard let self = self else {return}
                guard let _movies = movies else{return}
                self.movies = _movies.results
                self.NowPlayingCollectionView.reloadData()
            }
        }
    }
   func registerNib()  {
       let nibCell = UINib (nibName: CellID, bundle: nil)
             NowPlayingCollectionView.register(nibCell, forCellWithReuseIdentifier: CellID)
   }

    func createSearchBar(){
        
        searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
}


//MARK : -CollectionView Datasource and Delegate
extension NowPlayingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchFlag{
            return searchArray.count
        }else{
             return movies.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! NowPlayingCollectionViewCell
        var movie = result()
        if searchFlag{
             movie = searchArray[indexPath.row]
        }else{
             movie = movies[indexPath.row]
        }
        //let movie = movies[indexPath.row]
        cell.lblTitle.text = movie.title
        cell.lblOverview.text = movie.overview
        let strUrl = posterUrl + movie.poster_path!
        let url = URL(string: strUrl)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                       if let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                            cell.posterImgView.image = image
                           }
                       }
                   }
               }
        
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(showAlert(sender:)) )
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
        cell.addGestureRecognizer(UpSwipe)
        
        return cell
    }
    @objc func showAlert(sender: UISwipeGestureRecognizer) {
        
        let alertController = UIAlertController(title: "Delete Movie", message: "Are you sure want to delete the movie?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let cell = sender.view as! UICollectionViewCell
            let itemIndex = self.NowPlayingCollectionView.indexPath(for: cell)!.item
            self.movies.remove(at: itemIndex)
            self.NowPlayingCollectionView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nowPlayingDetailVC = storyboard.instantiateViewController(identifier: "idNowPlayingDetailViewController") as NowPlayingDetailViewController
        var movie = result()
        if searchFlag{
            movie = searchArray[indexPath.row]
        }else{
            movie = movies[indexPath.row]
        }
        if movie.backdrop_path != nil{
         backDropUrl = backDropMainUrl + movie.backdrop_path!
        }else{
            backDropUrl = ""
        }
        nowPlayingDetailVC.imgUrl = backDropUrl
        self.navigationController?.pushViewController(nowPlayingDetailVC, animated: true)
    }
}

//MARK : -Search bar delegate
extension NowPlayingViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFlag = true
        searchBar.showsCancelButton = true
        for i in 0..<movies.count{
            let content = movies[i]
            if content.title?.lowercased().contains(searchText.lowercased()) ?? false {
                searchArray.append(content)
                NowPlayingCollectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchFlag = false
        searchArray.removeAll()
        NowPlayingCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = true
        searchFlag = true
        searchBar.text = ""
        NowPlayingCollectionView.reloadData()
    }
}
