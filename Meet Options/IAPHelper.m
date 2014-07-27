//
//  IAPHelper.m
//  Meet Options
//
//  Created by The Wynn's  on 7/14/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//
// 1

#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>

// Add to top of file
NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";
// 2 Implement protocol in order to store lists of products
@interface IAPHelper () <SKProductsRequestDelegate,SKPaymentTransactionObserver>
@end

@implementation IAPHelper {
    // 3 Create instance variable to store product request
    SKProductsRequest * _productsRequest;
    
    // 4 Variables to keep track of completion, list of products, and already purchased products
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}


// Initiliaze with purchased products
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
//                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
//                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
    }
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    
    return self;
}

// Retrieve product info from iTunes
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}


// Delegate callbacks
#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
//    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
//    NSArray * skProducts = response.products;
    

    NSArray *skProducts = [response.products sortedArrayUsingComparator:^(id a, id b) {
        NSString *first = [(SKProduct*)a localizedTitle];
        NSString *second = [(SKProduct*)b localizedTitle];
        return [first compare:second];
    }];
    

//    for (SKProduct * skProduct in skProducts) {
//        NSLog(@"Found product: %@ %@ %0.2f",
//              skProduct.productIdentifier,
//              skProduct.localizedTitle,
//              skProduct.price.floatValue);
//    }
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
//    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    
//    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
//    NSLog(@"completeTransaction...");
    
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
//    NSLog(@"restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
//    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
//        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

// Add new method
- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    [_purchasedProductIdentifiers addObject:productIdentifier];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:productIdentifier userInfo:nil];
    
}
- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end