//
//  XYZDetailViewController.h
//  Option Pro
//
//  Created by The Wynn's  on 7/14/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
