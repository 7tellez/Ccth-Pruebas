//
//  Networking.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    
    static let shared = Networking()
    private init(){}
    
    func getUsers(completion: @escaping([User])->Void){
        do{
            let url = "\(APIs.GET_USUARIOS)"

            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.get.rawValue

            Alamofire.request(request).responseJSON { (response) in
                do{
                    let user:[User] = try JSONDecoder().decode([User].self, from: response.data!)
                    completion(user)
                }catch{
                    completion([User]())
                }
                print(response)
            }
        }catch{
            print("error en la descarga getUsers")
            completion([User]())
        }
    }
    func getPostUser(id: String,completion: @escaping([PostUser])->Void){
        do{
            let url = "\(APIs.GET_POST_USER)\(id)"
            print(url)
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.get.rawValue

            Alamofire.request(request).responseJSON { (response) in
                do{
                    let posts:[PostUser] = try JSONDecoder().decode([PostUser].self, from: response.data!)
                    completion(posts)
                }catch{
                    completion([PostUser]())
                }
                print(response)
            }
        }catch{
            print("error en la descarga getPostUser")
            completion([PostUser]())
        }
    }
}
