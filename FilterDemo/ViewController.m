//
//  ViewController.m
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize search_text;
@synthesize search_chapter;
@synthesize index_title;
@synthesize index_chapter;
@synthesize index_description;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setIndex_title:nil];
    [self setIndex_chapter:nil];
    [self setIndex_description:nil];
    [self setSearch_text:nil];
    [self setSearch_chapter:nil];
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
    [super dealloc];
}
- (IBAction)indexTapped:(id)sender {
}
- (IBAction)searchTapped:(id)sender {
}
@end
