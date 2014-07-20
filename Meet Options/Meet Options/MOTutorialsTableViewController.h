//
//  MOTutorialsTableViewController.h
//  Meet Options
//
//  Created by The Wynn's  on 7/15/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOMasterViewController.h"

@interface MOTutorialsTableViewController : MOMasterViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id detailItemLink;

@property (strong,nonatomic) NSArray *termsArray;
@property (strong,nonatomic) NSString *termsPath;


@property (strong,nonatomic) NSArray *linksArray;
@property (strong,nonatomic) NSString *linksPath;


@end
