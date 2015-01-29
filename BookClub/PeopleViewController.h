//
//  ViewController.h
//  BookClub
//
//  Created by Evan Vandenberg on 1/28/15.
//  Copyright (c) 2015 Evan Vandenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PeopleViewController : UIViewController

@property User *user;
@property User *mainUser;
@property NSManagedObjectContext *context;

@end

