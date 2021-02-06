//
//  ViewTableViewCell.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import UIKit

class ViewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    var viewVC:ViewController!
    var index:Int!
    var listUser: User!
        
    func setSell(viewVC:ViewController, index:Int,listUser: User){
        resetCell()
        self.viewVC = viewVC
        self.index = index
        self.listUser = listUser

        nameTitle.text = listUser.name
        phoneLabel.text = listUser.phone
        emailLabel.text = listUser.email
    }
    func resetCell(){
        nameTitle.text = ""
        phoneLabel.text = ""
        emailLabel.text = ""
    }

}
