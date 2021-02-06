//
//  DetailCollectionViewCell.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    var vc: DetailViewController!
//    var categoria : Categoria!
    var postUsuario: PostUser!


    func resetCell()
    {
        titleLabel.text = ""
        bodyLabel.text = ""
        vc = nil
    }
    
    func setCell(postUsuario: PostUser,vc: DetailViewController)
    {
        resetCell()
        
        self.vc = vc
        self.postUsuario = postUsuario
        
        titleLabel.text = postUsuario.title
        bodyLabel.text = postUsuario.body
    }
}
