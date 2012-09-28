//
//  FacetsTableViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 27/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocaytaSearch/LSLocaytaSearch.h>

@interface FacetsTableViewController : UITableViewController {
    SEL selectorForRowSelect;
    id targetForRowSelect;
}

@property (nonatomic, retain) LSLocaytaSearchResult *result;

- (void) setSelectorForRowSelect:(SEL)sel target:(id)target;

@end
