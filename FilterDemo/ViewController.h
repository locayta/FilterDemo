//
//  ViewController.h
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *index_title;
@property (retain, nonatomic) IBOutlet UITextField *index_chapter;
@property (retain, nonatomic) IBOutlet UITextField *index_description;
- (IBAction)indexTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *search_text;
@property (retain, nonatomic) IBOutlet UITextField *search_chapter;
- (IBAction)searchTapped:(id)sender;

@end
