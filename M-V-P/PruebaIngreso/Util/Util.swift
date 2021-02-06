//
//  Util.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation
import UIKit

public class Util{
    
    public static func verificarConexion() -> Bool {
        
        if !Reachability.isConnectedToNetwork() {
            return false
        }
        return true
    }
    
    public static func generarCodigo() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let dateString = formatter.string(from: now)
        return "i\(dateString)"
    }
    
    public static func codificarUrl(url:String) -> String {
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return safeURL
    }
    
    public static func alerta (titulo: String, mensaje: String, controller: UIViewController){
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        controller.present(alert, animated: true)
    }
    
    public static func generarFecha() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
