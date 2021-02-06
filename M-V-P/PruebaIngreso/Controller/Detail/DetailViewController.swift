//
//  DetailViewController.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var idUser: String!
    var listPost = [PostUser]()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.shared.show(view: self.view)
        idUser = String(user.id!)
        cargaLabel()
        loadPost()
        ProgressView.shared.dismiss()
    }
    func cargaLabel(){
        titleNameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
    func loadPost(){
        if !Util.verificarConexion(){
            Util.alerta(titulo: "Alerta", mensaje: Const.MENSAJE_CONEXION_INTERNET, controller: self)
            return
        }
        
        ProgressView.shared.show(view: self.view)
        Networking.shared.getPostUser(id: idUser){ (list) in
            if(list.count>0){
                self.listPost = list
                self.initCollectionView()
                self.setupCollectionView()
                SavePost.shared.saveUsers(listPost: list,idUser: Int(self.idUser) ?? 0)
                
            } else {
                Util.alerta(titulo: "Alerta", mensaje: Const.VACIO, controller: self)
            }
        }
        ProgressView.shared.dismiss()

    }
    func initCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func setupCollectionView(){
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            cellHeight: CGFloat(250)
        )
        collectionView.collectionViewLayout = columnLayout
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView{
            return listPost.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        if collectionView == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
            cell.setCell(postUsuario: listPost[indexPath.row], vc: self)
            return cell
        }
        return cell
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
   }
}

class SavePost{
    static let shared = SavePost()
    private init(){}
     var numero : Int!
    func saveUsers(listPost: [PostUser],idUser: Int){
        
        if idUser != nil {
            numero = idUser
        }else{
            numero = 0
        }
        
        for list in listPost{
            BDController().agregarPost(dbPath: Const.dbPath,publicacion: list,userId: Int64(numero!))
        }
    }
}

