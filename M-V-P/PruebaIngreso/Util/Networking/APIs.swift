//
//  APIs.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation

public class APIs {
    
    public static var PRUEBAS = "https://jsonplaceholder.typicode.com/"

    public static var base = PRUEBAS

    public static var GET_USUARIOS = base + "users"
    public static var GET_POST_USER = base + "posts?userId="

}
