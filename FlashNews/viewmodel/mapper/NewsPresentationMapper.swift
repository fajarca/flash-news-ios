//
//  NewsPresentationMapper.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

class NewsPresentationMapper {
    
    func map(articles : [Article]) -> [HeadlineViewViewModel]  {
        var news = [HeadlineViewViewModel]()
        for i in articles {
            news.append(HeadlineViewViewModel(sourceName: i.source.name, title: i.title, url: mapUrl(url: i.url), imageUrl: mapImageUrl(imageUrl: i.urlToImage), publishedAt: mapDate(isoDate: i.publishedAt)))
        }
        return news
    }
    
    private func mapUrl(url : String?) -> String {
        guard let url = url else { return "-" }
        return url
    }
    private func mapImageUrl(imageUrl : String?) -> String {
        guard let imageUrl = imageUrl else { return "-" }
        return imageUrl
    }
    private func mapDate(isoDate : String?) -> String {
        guard let isoDate = isoDate else { return "-" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.dateFormat = "HH:mm"
        let output = dateFormatter.string(from: date)
        return output
    }
}
