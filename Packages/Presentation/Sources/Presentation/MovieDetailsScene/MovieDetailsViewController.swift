//
//  MovieDetailsViewController.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import UIKit
import ImageCache

class MovieDetailsViewController: UIViewController {
    
    // MARK: Identifier
    public static let Identifier = String(describing: MovieDetailsViewController.self)
    
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var imageActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: Data
    public var movieAdapter: MovieAdapter? = nil
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadViewData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func loadViewData() {
        guard let movieAdapter else { return }
        self.movieNameLabel.text = movieAdapter.title
        self.movieDetailsLabel.text = movieAdapter.overview
        
        guard let imageURL = NSURL(string: movieAdapter.posterOriginal) else {
            return
        }
        ImageCache.shared.load(
            url: imageURL
        ) { [weak self] url, image in
            guard let self else { return }
            imageActivityIndecator.stopAnimating()
            backgroundImageView.image = image
            movieImageView.image = image
        }
    }
    
    private func setupUI() {
        let icon = UIImage(named: "left-arrow", in: Bundle(for: type(of: self)), compatibleWith: nil)
        backButton.setImage(icon, for: .normal)
    }
    
    //MARK: - Action
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
