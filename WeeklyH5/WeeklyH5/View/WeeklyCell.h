//
//  WeeklyCell.h
//  WeeklyH5
//
//  Created by MarkLin on 15/10/23.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeeklyNews;

#define ImageHeadLeadSpace 75
#define ImageHeadTrailingSpace 10
#define ImageHeadLeadGap 10

@interface WeeklyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *imageHeadVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratingHeight;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

- (void)configCellWithWeeklyNews:(WeeklyNews *)news andIndexPath:(NSIndexPath *)indexPath;


@end
