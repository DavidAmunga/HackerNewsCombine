//
//  Webservice.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import Foundation
import Combine

class Webservice{
    
    func getStoryById(storyId:Int)->AnyPublisher<Story,Error>{
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json?print=pretty") else{
            fatalError("Invalid Error")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .catch { _ in
                Empty<Story,Error>()
            }
            .eraseToAnyPublisher()
    }
    
    private func mergeStories(ids storyIds:[Int])->AnyPublisher<Story,Error>{
        let storyIds = Array(storyIds.prefix(50))
        
        let initialPublisher = getStoryById(storyId: storyIds[0])
        let remainder = Array(storyIds.dropFirst())
        
        
        return remainder.reduce(initialPublisher) { combined,id in
            return combined.merge(with: getStoryById(storyId: id))
                .eraseToAnyPublisher()
        }
    }
    
    func getAllTopStories()-> AnyPublisher<[Story],Error> {
        guard let url = URL(string:
                                "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")else{
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .flatMap({ storyIds in
                return self.mergeStories(ids: storyIds)
            })
            .scan([], { stories,story->[Story] in
                return stories + [story]
            })
            .eraseToAnyPublisher()
    }
}
