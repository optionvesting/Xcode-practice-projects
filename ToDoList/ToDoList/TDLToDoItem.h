//
//  TDLToDoItem.h
//  ToDoList
//
//  Created by The Wynn's  on 7/10/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
