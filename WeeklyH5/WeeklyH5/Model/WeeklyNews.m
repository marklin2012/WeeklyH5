//
//  WeeklyNews.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/23.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "WeeklyNews.h"

@implementation WeeklyNews

@dynamic title;
@dynamic rating;
@dynamic content;
@dynamic images;
@dynamic time;


+ (NSString *)parseClassName {
    return @"news";
}


@end
