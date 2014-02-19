//
//  ChapterFacetTableViewController.m
//  FilterDemo
//
//  Created by Nick Murdoch on 27/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import "FacetsTableViewController.h"

@interface FacetsTableViewController ()

@end

@implementation FacetsTableViewController

@synthesize result;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setSelectorForRowSelect:(SEL)sel target:(id)target {
    selectorForRowSelect = sel;
    targetForRowSelect = target;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger sections = [[result facets] count];
    if (!sections)
        sections = 1;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([[result facets] count] == 0)
        return 0;
    NSString *key = [[[result facets] allKeys] objectAtIndex:section];
    NSDictionary *facetData = [[result facets] objectForKey:key];
    return [facetData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[[result facets] allKeys] objectAtIndex:[indexPath section]];
    NSDictionary *facetData = [[result facets] objectForKey:key];
    
    static NSString *FacetCellIdentifier = @"FacetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FacetCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FacetCellIdentifier];
    }
    
    // Configure the cell...
    NSString *optionKey = [[facetData allKeys] objectAtIndex:[indexPath row]];
    NSNumber *optionValue = [facetData objectForKey:optionKey];
    
    [cell textLabel].text = [NSString stringWithFormat:@"%@ (%@ results)",
                             optionKey, optionValue];
    
    UIFont *myFont = [UIFont fontWithName: @"Helvetica" size: 14.0];
    cell.textLabel.font  = myFont;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Return the title for each section
    if ([[result facets] count] == 0)
        return @"Facets";
    NSString *key = [[[result facets] allKeys] objectAtIndex:section];
    return key;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSString *key = [[[result facets] allKeys] objectAtIndex:[indexPath section]];
    NSDictionary *facetData = [[result facets] objectForKey:key];
    NSString *optionKey = [[facetData allKeys] objectAtIndex:[indexPath row]];
    
    if (targetForRowSelect != nil) {
        [targetForRowSelect performSelector:selectorForRowSelect withObject:optionKey];
    }
}

@end
