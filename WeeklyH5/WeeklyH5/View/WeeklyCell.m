//
//  WeeklyCell.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/23.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "WeeklyCell.h"
#import "WeeklyNews.h"
#import "UIImageView+WebCache.h"

@implementation WeeklyCell
{
    CGFloat imageWidth;
    CGFloat imageHeight;
}

- (void)awakeFromNib {
    imageWidth = (ScreenWidth - ImageHeadLeadSpace - ImageHeadTrailingSpace - ImageHeadLeadGap*2)/3;
    
    imageHeight = (ScreenWidth - ImageHeadLeadSpace - ImageHeadTrailingSpace) * imageWidth / 8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)configCellWithWeeklyNews:(WeeklyNews *)news andIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < 3; i ++)
    {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 10];
        if (i < news.images.count)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:news.images[i]]];
            imageView.hidden = NO;
        }
        else
        {
            imageView.hidden = YES;
        }
        
        
    }
    
    self.titleLabel.text = news.title;
    self.contentLabel.text = news.content;
    if (indexPath.row == 0)
    {
        self.headerView.hidden = NO;
        self.monthLabel.text = [NSString stringWithFormat:@"%ld月",news.month];
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",news.day];;
    }
    else
    {
        self.headerView.hidden = YES;
    }
    
    if (news.rating)
    {
        self.ratingView.hidden = NO;
        self.ratingLabel.text = [NSString stringWithFormat:@"%@", news.rating];
        self.ratingHeight.constant = 26;
    }
    else
    {
        self.ratingView.hidden = YES;
        self.ratingHeight.constant = 0;
    }
}


@end
