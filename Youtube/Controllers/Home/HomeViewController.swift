//
//  HomeViewController.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    var model = Model()
    @IBOutlet weak var tableView: UITableView!
    var videos: [Video]?
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        let nib = UINib(nibName: "YoutubeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "YoutubeTableViewCell")
    }
    
    func getData() {
        model.getVideos()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeTableViewCell", for: indexPath) as? YoutubeTableViewCell else {
                return UITableViewCell()
            }
            
        let video = videos?[indexPath.row]
        cell.labelTitle.text = video?.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        if let publishedDate = video?.published {
            cell.labelDate.text = dateFormatter.string(from: publishedDate)
        }
        if let url = URL(string: video!.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.imageYoutube.image = UIImage(data: data)
                        cell.imageYoutube.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.video = videos?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: ModelDelegate {
    func didFetchVideos(_ videos: [Video]?) {
        if let videos = videos {
            self.videos = videos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Error fetching videos: \(error.localizedDescription)")
    }
}
