//
//  StoryDetailView.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import SwiftUI

struct StoryDetailView: View {
    @ObservedObject private var storyDetailViewModel:StoryDetailViewModel
    
    init(storyId:Int) {
        self.storyDetailViewModel = StoryDetailViewModel(storyId: storyId)
    }
    var body: some View {
        VStack {
            Text(self.storyDetailViewModel.title)
            Webview(url: self.storyDetailViewModel.url)
        }.onAppear {
            self.storyDetailViewModel.fetchStoryDetails(storyId: self.storyId)
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(storyId: 100)
    }
}
