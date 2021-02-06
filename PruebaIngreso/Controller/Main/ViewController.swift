//
//  ViewController.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SQLite3

class ViewController: UIViewController  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    lazy var listUserCopia = [User]()
    var listUser = [User]()
    lazy var tamano = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.shared.show(view: self.view)
        ConfigureDatabase.shared.database()
        loadUser()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))  //para cerrar teclado
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

    }
    func loadUser(){
        if !Util.verificarConexion(){
            print(Const.MENSAJE_CONEXION_INTERNET)
            Util.alerta(titulo: "Alerta", mensaje: Const.MENSAJE_CONEXION_INTERNET, controller: self)
            return
        }

        ChargueUser.shared.loadUser(){ (usuarios) in
            if usuarios.count > 0 {
                self.listUser = usuarios
                self.listUserCopia = usuarios
                self.initTableView()
                SaveUser.shared.saveUsers(usuarios: usuarios)
            }else{
                Util.alerta(titulo: "Alerta", mensaje: Const.VACIO, controller: self)
            }
        }
        ProgressView.shared.dismiss()

    }
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func hideKeyboard() {
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func search(_ sender: UITextField) {
        
        let busqueda = sender.text
        if tamano >= busqueda!.count{
            listUser = listUserCopia
        }
        listUser = listUser.filter { $0.name!.lowercased().contains(busqueda!.lowercased()) }

        if busqueda == ""{
            listUser = listUserCopia
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tamano = busqueda!.count
    }
    @IBAction func salir(_ sender: Any) {
        BDController().deleteFilesDbs()
        exit (0);
    }
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewTableViewCell") as! ViewTableViewCell
        cell.setSell(viewVC: self, index: indexPath.row, listUser: listUser[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SendData.shared.openVc(listUser: listUser[indexPath.row],viewC: self)
    }
}

class ChargueUser {
    static let shared = ChargueUser()
    private init(){}
    
    func loadUser(completion: @escaping([User])->Void){
        Networking.shared.getUsers(){ (usuarios) in
                completion(usuarios)//true
        }
    }
}
class SaveUser{
    static let shared = SaveUser()
    private init(){}
    
    func saveUsers(usuarios: [User]){
        if  BDController().existeInformacion(){}else{
            for usuario in usuarios{
                BDController().agregarUsuarios(dbPath: Const.dbPath,usuario: usuario)
            }
        }
    }
}
class SendData {
    static let shared = SendData()
    private init(){}

    func openVc(listUser: User,viewC: ViewController){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        vc.user = listUser
        viewC.present(vc, animated: true)
    }
}
class ConfigureDatabase {
    var db: OpaquePointer?
    lazy var dbPath = ""
    
    static let shared = ConfigureDatabase()
    private init(){}
    
    func database(){
        if BDController().existenArchivosDb(){
            print("existe database")
        }else{
            print("no existe database")
            checkDB()
        }
    }
    func checkDB(){
        if sqlite3_open(Const.fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Usuario (id integer PRIMARY KEY NOT NULL,nombre varchar(128) DEFAULT('NOT NULL'),email varchar(128) DEFAULT('NOT NULL'));", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Post (id integer PRIMARY KEY NOT NULL,title varchar(128) DEFAULT('NOT NULL'),body varchar(128) DEFAULT('NOT NULL'),id_usuario integer(128) DEFAULT(NOT NULL),FOREIGN KEY (id_usuario) REFERENCES Usuario (Id));", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
}

