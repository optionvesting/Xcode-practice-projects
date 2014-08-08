//
//  IADViewController.h
//  InAppDemo
//
//  Created by The Wynn's  on 7/12/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "PurchaseViewController.h"

@interface IADViewController : UIViewController

- (IBAction)purchaseItem:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *level2Button;
@property (strong, nonatomic) PurchaseViewController *purchaseController;
-(void)enableLevel2;
@end