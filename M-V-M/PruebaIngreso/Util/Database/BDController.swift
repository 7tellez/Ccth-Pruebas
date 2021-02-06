//
//  BDController.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation
import SQLite

class BDController {
    var db: Connection?
    
    func openDataBase(dbPath: String) -> Bool{
        do{
            db = try Connection(dbPath)
            return true
        }catch{
            return false
        }
    }
    func existenArchivosDb()->Bool{
        let fileExistsDB = FileManager().fileExists(atPath: Const.rutaBaseDB)
        print(fileExistsDB, Const.rutaBaseDB)
        return fileExistsDB
    }
    func deleteFilesDbs(){
        _ = try? FileManager().removeItem(atPath: Const.rutaBaseDB)
    }
    func existeInformacion() -> Bool {
        
        var hayPedidosPendientes = false
        var query = ""
        
        do {
            let db = try Connection(Const.rutaBaseDB, readonly: false) 
            query = "SELECT COUNT(*) AS Total FROM Usuario"
            
            let stmt = try db.prepare(query)
            
            for row in stmt{
                if (row[0] as! Int64?)! > 0 {
                    hayPedidosPendientes = true
                }
            }
        } catch {
            print("Consulta existeInformacion -> \(error)")
        }
        
        return hayPedidosPendientes
    }
    
    func agregarUsuarios(dbPath: String, usuario: User){
        if(openDataBase(dbPath: dbPath)){
            do{
                let insertStatement = "INSERT INTO Usuario(id, nombre, email) VALUES ('\(usuario.id!)','\(usuario.name!)','\(usuario.email!)')"
                try db?.run(insertStatement)
                print("\(usuario.name!) usuario agregagada con exito")
            }catch{
                print("\(usuario.id) usuario agregar error  ",error)
            }
        }
    }
    func agregarPost(dbPath: String, publicacion: PostUser,userId: Int64){
        if(openDataBase(dbPath: dbPath)){
            do{
                let insertStatement = "INSERT INTO Post(id, title, body,id_usuario) VALUES ('\(publicacion.id!)','\(publicacion.title!)','\(publicacion.body!)','\(userId)')"
                try db?.run(insertStatement)
                print("\(publicacion.title!) publicacion agregagada con exito")
            }catch{
                print("\(publicacion.id) publicacion agregar error  ",error)
            }
        }
    }
}
