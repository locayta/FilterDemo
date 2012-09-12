//
//  AppDelegate.h
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocaytaSearch/LSLocaytaSearch.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, LSLocaytaSearchIndexerDelegate, LSLocaytaSearchRequestDelegate> {
    LSLocaytaSearchIndexer *indexer;
    LSLocaytaSearchRequest *request;
    NSDictionary *schema;
}

@property (nonatomic, strong) UIViewController *viewcontroller;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) LSLocaytaSearchIndexer *indexer;
@property (nonatomic, retain) LSLocaytaSearchRequest *request;
@property (nonatomic, retain) NSDictionary *schema;

@end
