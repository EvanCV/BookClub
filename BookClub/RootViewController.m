//
//  RootViewController.m
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import "RootViewController.h"
#import "PeopleViewController.h"
#import "BookViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property User *mainUser;
@property NSMutableArray *friendsListArray;
@property NSManagedObjectContext *context;


@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    [self loadFromUsers];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self loadFromUsers];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    User *user = self.friendsListArray[indexPath.row];

    cell.textLabel.text = user.name;


    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsListArray.count;
}


-(void)loadFromUsers
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    self.friendsListArray = [[self.context executeFetchRequest:request error:nil]mutableCopy];
    self.mainUser = self.friendsListArray.firstObject;
    self.friendsListArray = [[self.mainUser.friends allObjects]mutableCopy];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Book"])
    {
        BookViewController *bvc = segue.destinationViewController;
        User *selectedUser = self.friendsListArray[self.tableView.indexPathForSelectedRow.row];
        bvc.user = selectedUser;
    }
    else
    {
    PeopleViewController *pvc = segue.destinationViewController;
    pvc.mainUser = self.mainUser;
    pvc.context = self.context;
    }
}

@end
