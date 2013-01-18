//
//  ViewController.m
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize results_table;
@synthesize facets_table;
@synthesize search_text;
@synthesize search_chapter;
@synthesize index_title;
@synthesize index_chapter;
@synthesize index_description;
@synthesize remove_refinement;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /* Create a reference to this controller in the AppDelegate, which is
       currently also the LSLocaytaSearchIndexer and Request delegate. */
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.viewcontroller = self;
    
    /* Wire up the results table view */
    rtvc = [[ResultsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    results_table.delegate = rtvc;
    results_table.dataSource = rtvc;
    
    /* Wire up the chapter facet table view */
    ftvc = [[FacetsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    facets_table.delegate = ftvc;
    facets_table.dataSource = ftvc;
    [ftvc setSelectorForRowSelect:@selector(facetCellTapped:) target:self];
    
    /* Put borders around the facet and results table view */
    [facets_table.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [facets_table.layer setBorderWidth:1.0];
    [results_table.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [results_table.layer setBorderWidth:1.0];
    
    /* Hide the Remove Refinement button until we need it */
    remove_refinement.hidden = YES;
    
    /* Set the search button's "searching" text */
    [self.searchButton setTitle:@"Searching" forState:UIControlStateDisabled];
}

- (void)viewDidUnload
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.viewcontroller = nil;
    [rtvc dealloc];
    [self setIndex_title:nil];
    [self setIndex_chapter:nil];
    [self setIndex_description:nil];
    [self setSearch_text:nil];
    [self setSearch_chapter:nil];
    [self setResults_table:nil];
    [self setFacets_table:nil];
    [self setRemove_refinement:nil];
    [self setSearchButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [index_title release];
    [index_chapter release];
    [index_description release];
    [search_text release];
    [search_chapter release];
    [results_table release];
    [facets_table release];
    [remove_refinement release];
    [_searchButton release];
    [super dealloc];
}

- (IBAction)indexTapped:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"appDelegate: %@, schema: %@", [appDelegate description], appDelegate.schema);
    LSLocaytaSearchIndexableRecord *record = [[LSLocaytaSearchIndexableRecord alloc] initWithSchema:appDelegate.schema];
    
    NSError *error = nil;
    
    if (![record addValue:[index_title text] forField:@"title" error:&error]) {
        NSLog(@"Error: %@", [error localizedDescription]);    // handle error
    }
    if (![record addValue:[index_chapter text] forField:@"chapter" error:&error]) {
        NSLog(@"Error: %@", [error localizedDescription]);    // handle error
    }
    if (![record addValue:[index_description text] forField:@"description" error:&error]) {
        NSLog(@"Error: %@", [error localizedDescription]);    // handle error
    }
    
    [appDelegate.indexer addOrReplaceRecord:record];
    // returns immediately as operation is performed asynchronously. A delegate method will be called when completed (or failed).
    
    [record release];
}

- (IBAction)searchTapped:(id)sender {
    NSString *queryString = [NSString stringWithString:search_text.text];
    NSString *chapterText = [NSString stringWithString:search_chapter.text];
    
    if ([chapterText length] == 0) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"chapter ([1-9][0-9]*)" options:NSRegularExpressionCaseInsensitive error:&error];
        if (error != nil) {
            NSLog(@"Regex error %@", [error localizedDescription]);
        }
        NSTextCheckingResult *match = [regex firstMatchInString:queryString options:0 range:NSMakeRange(0, [queryString length])];
        chapterText = [queryString substringWithRange:[match rangeAtIndex:1]];
        queryString = [queryString stringByReplacingCharactersInRange:[match range] withString:@""];
        
        NSLog(@"queryString now: %@; chapterText now: %@", queryString, chapterText);
        /* Replace the original text with the new versions too */
        search_text.text = queryString;
        search_chapter.text = chapterText;
    }
    
    LSLocaytaSearchQuery *query = [LSLocaytaSearchQuery queryWithQueryString:queryString];
    
    if ([chapterText length] > 0) {
        NSDictionary * filters = [NSDictionary dictionaryWithObjectsAndKeys:
                                  chapterText, @"chapter",
                                  nil];
        query.filters = filters;
        remove_refinement.hidden = NO;
    } else {
        remove_refinement.hidden = YES;
    }
    
    NSArray *facets = [NSArray arrayWithObject:@"chapter"];
    
    /* Reset the table views: */
    [self populateSearchResultListing:nil];
    
    /* Deactivate the search button while searching is in progress: */
    [self.searchButton setEnabled:NO];
    [self.searchButton setAlpha:0.6f];
    
    /* Perform the search: */
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.request searchWithQuery:query topDocIndex:0 docsPerPage:10 facets:facets];

}

- (void) populateSearchResultListing:(LSLocaytaSearchResult *)searchResult {
    /* Called when searches successfully complete */
    rtvc.result = searchResult;
    ftvc.result = searchResult;
    [results_table reloadData];
    [results_table reloadInputViews];
    [facets_table reloadData];
    [facets_table reloadInputViews];
    
    /* Re-enable the search button */
    [self.searchButton setAlpha:1.0f];
    [self.searchButton setEnabled:YES];
}

- (void) facetCellTapped:(NSString *)chapterString {
    search_chapter.text = chapterString;
    [self searchTapped:nil];
}


- (IBAction)removeRefinementTapped:(id)sender {
    search_chapter.text = @"";
    [self searchTapped:nil];
}

/* Generic remove-keyboard method for all text fields' didEndOnExit */
- (IBAction)genericTextFieldDone:(id)sender {
    [sender resignFirstResponder];
}

@end