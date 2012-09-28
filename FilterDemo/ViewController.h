//
//  ViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocaytaSearch/LSLocaytaSearch.h>
#import "ResultsTableViewController.h"
#import "FacetsTableViewController.h"

@interface ViewController : UIViewController {
    ResultsTableViewController *rtvc;
    FacetsTableViewController *ftvc;
}
@property (retain, nonatomic) IBOutlet UITextField *index_title;
@property (retain, nonatomic) IBOutlet UITextField *index_chapter;
@property (retain, nonatomic) IBOutlet UITextField *index_description;
- (IBAction)indexTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *search_text;
@property (retain, nonatomic) IBOutlet UITextField *search_chapter;
- (IBAction)searchTapped:(id)sender;
- (void)facetCellTapped:(NSString*)chapterString;
- (void)populateSearchResultListing:(LSLocaytaSearchResult *)searchResult;

@property (retain, nonatomic) IBOutlet UIButton *remove_refinement;
- (IBAction)removeRefinementTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *results_table;
@property (retain, nonatomic) IBOutlet UITableView *facets_table;

@end
