//
//  MOGlossaryDetailViewController.h
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MODetailViewController.h"

@interface MOGlossaryDetailViewController : MODetailViewController
@property (strong, nonatomic) IBOutlet UIWebView *glossaryDefinitionWebView;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
