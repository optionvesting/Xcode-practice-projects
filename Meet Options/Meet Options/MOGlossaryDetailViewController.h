//
//  MOGlossaryDetailViewController.h
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MODetailViewController.h"
#import <UIKit/UIKit.h>

@interface MOGlossaryDetailViewController : MODetailViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *glossaryDefinitionWebView;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
- (IBAction)onStepperTapped:(id)sender;
@end
