//
//  CommentsViewController.h
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "User.h"

@interface CommentsViewController : UIViewController

@property Book *book;
@property User *user;

@end
