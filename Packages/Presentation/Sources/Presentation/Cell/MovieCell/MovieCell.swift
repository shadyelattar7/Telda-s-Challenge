//
//  MovieCell.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import UIKit
import Extensions

class MovieCell: UICollectionViewCell {
    //MARK: - @IBOutlet
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviewName: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Properties
    private var viewModel: MovieAdapter? {
        didSet {
            guard let viewModel = viewModel else {return}
            setData(from: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
        
        movieImage.layer.cornerRadius = 12.0
        movieImage.layer.masksToBounds = true
    }
    
    private func setData(from viewModel: MovieAdapter) {
       let poster = URL(string: viewModel.posterOriginal)
        movieImage.setImage(with: poster)
        moviewName.text = viewModel.title
        movieRate.text = "\(viewModel.voteAverage)"
        dateLabel.text = viewModel.releaseDate
    }
    
    func configuration(viewModel: MovieAdapter){
        self.viewModel = viewModel
    }
}
