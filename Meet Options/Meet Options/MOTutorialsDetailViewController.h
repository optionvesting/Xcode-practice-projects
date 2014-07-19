//
//  MOTutorialsDetailViewController.h
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MODetailViewController.h"
#import <UIKit/UIKit.h>

@interface MOTutorialsDetailViewController : MODetailViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *tutorialsDefinitionWebView;

@property (strong, nonatomic) id detail;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
- (IBAction)onStepperTapped:(id)sender;
@end
