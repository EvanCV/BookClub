//
//  BookViewController.m
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import "BookViewController.h"
#import "AddBooksViewController.h"
#import "User.h"
#import "Book.h"
#import "Comment.h"

@interface BookViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *booksArray;

@end

@implementation BookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.user.name;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self loadNewBooks];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Book *book = [self.booksArray objectAtIndex:indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksArray.count;
}

-(void)loadNewBooks
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([User class])];
    self.booksArray = [self.user.managedObjectContext executeFetchRequest:request error:nil];
    self.booksArray = [self.user.books allObjects];
    [self.tableView reloadData];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddBooksViewController *avc = segue.destinationViewController;
    avc.user = self.user;
    
}


@end
