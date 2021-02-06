//
//  Const.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation

public class Const {
    
    public static let MENSAJE_CONEXION_INTERNET = "No hay conexion a internet."
    public static let VACIO = "No se encontro información..."
    
    //MARK: - RUTA BASE DE DATOS
    public static var rutabd = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    public static let rutaBaseDB = rutabd.appending("/ingreso.sqlite3")
    
    public static let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                   .appendingPathComponent("ingreso.sqlite3")
    public static let dbPath = fileURL.relativeString.replacingOccurrences(of: "file://", with: "")


}
