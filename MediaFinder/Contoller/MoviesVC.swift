//
//  MoviesVC.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/27/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MoviesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var mediaArr: [Media]! = [Media]()
    var postShown = [Bool](repeating: false, count: 100)
    var searchBarText: String!
    var segmentedText: String = "tvShow"
    var emailCashed: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Media Finder"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.hidesBackButton = true

        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        tableView.register(UINib.init(nibName: cells.moviesCell, bundle: nil), forCellReuseIdentifier: cells.moviesCell)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
         emailCashed = UserDefaults.standard.string(forKey: "Email")
        //ableView animation
        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        getHistoryDataFromDatabase()
        
    }
  

    @IBAction func openProfilePressed(_ sender: Any) {
        ProfileVC.checkEmail = UserDefaults.standard.string(forKey: "Email")
        Navigation().instantiateViewController(Controller: ProfileVC.self, Action: .Push ,Navigation: self.navigationController!)
        
    }
    
    enum mediaType: String {
        case music
        case movie
        case tvShow
    }
    
    @IBAction func segmentedChoice(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex {
        case 0:
            segmentedText = mediaType.tvShow.rawValue
            getSearchBarTextAndCallApi()
            break
        case 1:
            segmentedText = mediaType.movie.rawValue
            getSearchBarTextAndCallApi()
            break
        case 2:
            segmentedText = mediaType.music.rawValue
            getSearchBarTextAndCallApi()
            break
        default:
            break
        }
        
    }
    
    func getHistoryDataFromDatabase() {
        
        DataBaseManager.shared().getHistoryAndCallApi(emailCashed: emailCashed) { (search, segmented) in
            Apimanager.loadItunesMedia(criteria: search ?? "", mediaType: segmented ?? "") { (error, movies) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let movies = movies{
                    self.mediaArr = movies
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    private func getDataFromApi() {
        Apimanager.loadItunesMedia(criteria: searchBarText, mediaType: segmentedText) { (error, movies) in
            if let error = error {
                print(error.localizedDescription)
            } else if let movies = movies{
                self.mediaArr = movies
                self.tableView.reloadData()
                
            }
        }
        DataBaseManager.shared().insertHistory(searth: searchBarText, segmented: segmentedText, email: emailCashed)
    }
    
    private func getSearchBarTextAndCallApi() {
        guard let search = searchBar.text, !searchBar.text!.isEmpty else {
            alertExt(title: "Search bar is empty", message: "Please enter what you want to search", style: .alert)
            return
            
        }
        searchBarText = search
        getDataFromApi()
    }
    

}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArr.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cells.moviesCell, for: indexPath) as? MoviesCell else {
            return UITableViewCell()
        }
        
        switch segmentedText {
        case mediaType.tvShow.rawValue:
            cell.firstLabel.text = mediaArr[indexPath.row].artistName
            cell.secondLabel.text = mediaArr[indexPath.row].longDescription
        case mediaType.movie.rawValue:
            cell.firstLabel.text = mediaArr[indexPath.row].trackName
            cell.secondLabel.text = mediaArr[indexPath.row].longDescription
        case mediaType.music.rawValue:
            cell.firstLabel.text = mediaArr[indexPath.row].trackName
            cell.secondLabel.text = mediaArr[indexPath.row].artistName
            
        default:
            break
        }
        
        cell.movieImage?.sd_setImage(with: URL(string: mediaArr[indexPath.row].artworkUrl100), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let videoUrl = URL(string: mediaArr[indexPath.row].previewUrl)
        let player = AVPlayer(url: videoUrl!)
        let vc = AVPlayerViewController()
        vc.player = player
        
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Determine if the post is displayed. If yes, we just return and no animation will be created
        if postShown[indexPath.row] {
            return
        }
        
        // Indicate the post has been displayed, so the animation won't be displayed again
        postShown[indexPath.row] = true
        
        // Define the initial state (Before the animation)
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        
        // Define the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
}
    


extension MoviesVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchBarTextAndCallApi()
    }
}


