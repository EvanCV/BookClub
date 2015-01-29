//
//  AddBooksViewController.m
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import "AddBooksViewController.h"

@interface AddBooksViewController ()
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@end

@implementation AddBooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)onAddButtonTapped:(UIButton *)sender
{
    Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:[Book description] inManagedObjectContext:self.user.managedObjectContext];
    newBook.title = self.titleTextField.text;
    newBook.author = self.authorTextField.text;
    
    [self.user addBooksObject:newBook];
    [self.user.managedObjectContext save:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
