//
//  ContactCell.swift
//  proto-tableview-animate-ios
//
//  Created by Santosh Krishnamurthy on 3/25/23.
//

import UIKit

class ContactCell: UITableViewCell {

    var link: ViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // every cell
        let starButton = UIButton(type: .system)
        //starButton.setTitle("Star", for: .normal)
        starButton.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
        starButton.tintColor = .red
        starButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        accessoryView = starButton
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        
    }
    
    @objc func handleMarkAsFavorite(){
        print("Mark as favorite")
        link?.setFavoriteContact(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
