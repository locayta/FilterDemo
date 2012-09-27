//
//  FacetsTableViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 27/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocaytaSearch/LSLocaytaSearch.h>

@interface FacetsTableViewController : UITableViewController

@property (nonatomic, retain) LSLocaytaSearchResult *result;

@end
