//
//  TopHeadlinesResponse.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

struct TopHeadlinesResponse: Decodable {
  let all: [Article]
  
  enum CodingKeys: String, CodingKey {
    case all = "articles"
  }
}

