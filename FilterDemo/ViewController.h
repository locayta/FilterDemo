//
//  ViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
- (IBAction)resetTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *search_text;
@property (retain, nonatomic) IBOutlet UITextField *search_chapter;
@property (retain, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)searchTapped:(id)sender;
- (void)facetCellTapped:(NSString*)chapterString;
- (void)populateSearchResultListing:(LSLocaytaSearchResult *)searchResult;

@property (retain, nonatomic) IBOutlet UIButton *remove_refinement;
- (IBAction)removeRefinementTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *results_table;
@property (retain, nonatomic) IBOutlet UITableView *facets_table;

@end
