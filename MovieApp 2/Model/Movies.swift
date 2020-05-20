//
//  Movies.swift
//  MovieApp 2
//
//  Created by Pooja kumbhar on 20/05/20.
//  Copyright © 2020 Pooja kumbhar. All rights reserved.
//

import Foundation
struct Movies: Decodable{
    
    var results : [result]
}

struct result: Decodable {
    var poster_path: String?
    var backdrop_path: String?
    var title: String?
    var overview: String?
    
}
