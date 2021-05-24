//
//  StoryListViewModel.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import Foundation
import Combine


class StoryListViewModel:ObservableObject{
    @Published var stories = [StoryViewModel]()
    private var cancellable : AnyCancellable?
    
    init() {
        fetchTopStories()
    }
    
    private func fetchTopStories(){
        
        self.cancellable =  Webservice().getAllTopStories().map{stories in
            stories.map { StoryViewModel(story:$0)}
        }.sink { _ in
        } receiveValue: { storyViewModels in
            self.stories = storyViewModels
        }

    }
}


struct StoryViewModel{
    
    let story:Story
    
    var id:Int{
        return self.story.id
    }
    var title:String{
        return self.story.title
    }
    var url:String{
        return self.story.url
    }
    
}
