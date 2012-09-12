//
//  ResultsTableViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocaytaSearch/LSLocaytaSearch.h>

@interface ResultsTableViewController : UITableViewController

@property (nonatomic, retain) LSLocaytaSearchResult *result;

@end
