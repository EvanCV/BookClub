//
//  ViewController.m
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import "PeopleViewController.h"
#import "RootViewController.h"
#import "DataManager.h"
#import "AppDelegate.h"

@interface PeopleViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *friendsArray;
@property NSMutableArray *selectedArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PeopleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.friendsArray = [NSMutableArray new];
        self.selectedArray = [NSMutableArray new];

    self.tableView.allowsMultipleSelectionDuringEditing=true;
    [self.tableView setEditing:true];

    [self loadUsers];
}

-(void)loadUsers
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    self.friendsArray = [[self.context executeFetchRequest:request error:nil]mutableCopy];
    [self.tableView reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    User *user =  [self.friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = user.name;

    if ([self.mainUser.friends containsObject:user])
    {
        //Programmatically select the current row if the row is already a friend of main user
        [tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
            }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mainUser removeFriendsObject:self.friendsArray[indexPath.row]];
    [self.context save:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.mainUser addFriendsObject:self.friendsArray[indexPath.row]];
    [self.context save:nil];
}








@end
