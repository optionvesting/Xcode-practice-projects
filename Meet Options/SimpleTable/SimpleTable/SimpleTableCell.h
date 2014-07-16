//
//  SimpleTableCell.h
//  SimpleTable
//
//  Created by The Wynn's  on 7/9/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *rightImageView;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
