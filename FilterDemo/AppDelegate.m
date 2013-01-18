//
//  AppDelegate.m
//  FilterDemo
//
//  Created by Nick Murdoch on 12/09/2012.
//  Copyright (c) 2012 Locayta Ltd. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize viewcontroller;
@synthesize indexer;
@synthesize request;
@synthesize schema;

- (void)dealloc
{
    [indexer release];
    [request release];
    [schema release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSArray *document_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents_dir = [document_paths objectAtIndex:0];
    NSString *dbpath = [documents_dir stringByAppendingPathComponent:@"search_db"];

    NSString *schemaFilename = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"schema.plist"];
    NSDictionary *indexSchema = [[NSDictionary alloc] initWithContentsOfFile:schemaFilename];
    
    if (![LSLocaytaSearchIndexer databaseExistsAtPath:dbpath]) {
        NSError * error;
        NSLog(@"Creating new index at %@", dbpath);
        [LSLocaytaSearchIndexer createDatabaseAtPath:dbpath error:&error];
        if (error) {
            NSLog(@"Unable to create database: %@", [error localizedDescription]);
        }
    }
    
    indexer = [[LSLocaytaSearchIndexer alloc] initWithDatabasePath:dbpath delegate:self];
    request = [[LSLocaytaSearchRequest alloc] initWithDatabasePath:dbpath delegate:self];
    schema = indexSchema;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

# pragma mark Locayta Search delegate methods

- (void) locaytaSearchIndexer:(LSLocaytaSearchIndexer *)searchIndexer didUpdateWithIndexableRecords:(NSArray *)indexableRecords {
    NSLog(@"Indexing succeeded");
}

- (void) locaytaSearchIndexer:(LSLocaytaSearchIndexer *)searchIndexer didFailToUpdateWithIndexableRecords:(NSArray *)indexableRecords error:(NSError *)error {
    NSLog(@"Indexing failed: %@", [error localizedDescription]);
}

- (void) locaytaSearchRequest:(LSLocaytaSearchRequest *)searchRequest didCompleteWithResult:(LSLocaytaSearchResult *)searchResult {
    NSLog(@"Search request succeeded; %d results", [searchResult itemCount]);
    [viewcontroller populateSearchResultListing:searchResult];
}

- (void) locaytaSearchRequest:(LSLocaytaSearchRequest *)searchRequest didFailWithError:(NSError *)error {
    NSLog(@"Search request failed: %@", [error localizedDescription]);
    [viewcontroller populateSearchResultListing:nil];
}

@end
