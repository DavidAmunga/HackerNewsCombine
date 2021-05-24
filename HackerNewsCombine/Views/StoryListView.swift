//
//  StoryListView.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import SwiftUI

struct StoryListView: View {
    @ObservedObject private var storyListViewModel = StoryListViewModel()
    
    var body: some View {
        NavigationView{
            
            
            List(self.storyListViewModel.stories,id:\.id){ storyViewModel in
                NavigationLink(
                    destination: StoryDetailView(storyId:storyViewModel.id),
                    label: {
                        Text("\(storyViewModel.title)")
                    })
            }
            
            
            .navigationBarTitle("Hacker News")
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
