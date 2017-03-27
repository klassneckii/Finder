//
//  SearchResultCell.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell, ConfigurableStaticHeightCell {
    
    internal static var cellHeight: CGFloat = 90.0
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    weak var delegate: SearchResultCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tapCover(sender:)))
        coverImageView.addGestureRecognizer(tapGesture)
        coverImageView.isUserInteractionEnabled = true
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
    }
    
    func tapCover(sender: UITapGestureRecognizer) {
        delegate?.coverImageViewTapped(coverImageView: coverImageView)
    }
    
    func configure(with viewModel: CellViewModel) {
        guard let viewModel = viewModel as? SearchResultViewModel else {
            return
        }
        let киса = UIView.init()
        киса.frame = bounds
        headingLabel.text = viewModel.heading
        bodyLabel.text = viewModel.body
        delegate = viewModel.delegate
    }
    
    func setRightLayout() {
        contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
        coverImageView.transform = CGAffineTransform(scaleX: -1,y: 1);
        headingLabel.transform = CGAffineTransform(scaleX: -1,y: 1);
        headingLabel.textAlignment = .right;
        bodyLabel.transform = CGAffineTransform(scaleX: -1,y: 1);
        bodyLabel.textAlignment = .right;
    }
    
    func setLeftLayout() {
        contentView.transform = .identity
        coverImageView.transform = .identity
        headingLabel.transform = .identity
        headingLabel.textAlignment = .left;
        bodyLabel.transform = .identity
        bodyLabel.textAlignment = .left;
    }
}
