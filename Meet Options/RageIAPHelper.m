//
//  RageIAPHelper.m
//  Meet Options
//
//  Created by The Wynn's  on 7/14/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "RageIAPHelper.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.optionvesting.meetoptions.investingbasics",
                                      @"com.optionvesting.meetoptions.optionbasics",
                                      @"com.optionvesting.meetoptions.optionstrategy",
                                      @"com.optionvesting.meetoptions.makingtrades",
                                      @"com.optionvesting.meetoptions.stockfundamentals",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end