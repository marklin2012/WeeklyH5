//
//  WeeklyNews.h
//  WeeklyH5
//
//  Created by MarkLin on 15/10/23.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface WeeklyNews : AVObject<AVSubclassing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;


@end
