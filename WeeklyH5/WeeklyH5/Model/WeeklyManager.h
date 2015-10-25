//
//  WeeklyManager.h
//  WeeklyH5
//
//  Created by MarkLin on 15/10/24.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeeklyNews;

typedef void(^WeeklyFinishLoading)(void);

@interface WeeklyManager : NSObject

@property (nonatomic, strong) NSMutableArray *showsNews;


+ (instancetype)shareInstance;

- (void)loadDatasWithFinishLoading:(WeeklyFinishLoading)finish;
@end
