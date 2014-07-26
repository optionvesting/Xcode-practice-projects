//
//  MOSupportDetailViewController.h
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MODetailViewController.h"
#import <UIKit/UIKit.h>

@interface MOSupportDetailViewController : MODetailViewController
@property (strong, nonatomic) IBOutlet UIWebView *supportWebView;
@property (strong, nonatomic) id detailItem;


@property (strong, nonatomic) id detail;
@property (strong, nonatomic) id link;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
- (IBAction)onStepperTapped:(id)sender;



@end
