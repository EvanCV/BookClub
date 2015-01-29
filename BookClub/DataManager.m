//
//  DataManager.m
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "User.h"

@interface DataManager ()

@property NSManagedObjectContext *context;

@end

@implementation DataManager



- (void)getFriendsListFromWeb
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;

    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               NSArray *webDataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                               NSArray *jsonArray = [[NSArray alloc]initWithArray:webDataArray];
                               for (NSString *string in jsonArray)
                               {
                                   User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
                                   user.name = string;
                                   [self.context save:nil];

                               }}];
}


@end
