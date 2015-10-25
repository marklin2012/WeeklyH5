//
//  WeeklyManager.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/24.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "WeeklyManager.h"
#import "WeeklyDayGroup.h"
#import "WeeklyNews.h"

static WeeklyManager *manager = nil;

@implementation WeeklyManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager)
        {
            manager = [[[self class] alloc] init];
        }
    });
    return manager;
}



- (void)loadDatasWithFinishLoading:(WeeklyFinishLoading)finish
{
    //清空数据源，重新加载
    [self.showsNews removeAllObjects];
    self.showsNews = nil;
    [AVQuery clearAllCachedResults];
    
    AVQuery *query = [WeeklyNews query];
    //设置缓存策略
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSInteger dayTime = 0;
        WeeklyDayGroup *group = nil;
        BOOL isLastFlag = NO;
        for (WeeklyNews *news in objects)
        {
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:news.updatedAt];
            //获取月份和日期
            news.month = [NSString stringWithFormat:@"%ld",[components month]];
            news.day = [NSString stringWithFormat:@"%ld",[components day]];
            
            
            NSTimeInterval timeInterval = [news.updatedAt timeIntervalSince1970];
            
            //1445792600.095
            // 16733
            //  今天1445731200
            if (dayTime == 0)
            {
                //第一个元素
                dayTime = (NSInteger)timeInterval/(60*60*24);
                group = [[WeeklyDayGroup alloc] init];
                group.timeInterval = (NSTimeInterval)dayTime*60*60*24;
                if (!group.weeklyNews)
                {
                    group.weeklyNews = [NSMutableArray array];
                }
                
                //添加元素
                [group.weeklyNews addObject:news];
                isLastFlag = YES;
                
            }
            else
            {
                NSInteger currentDayTime = (NSInteger)timeInterval/(60*60*24);
                //如果数据都在同一天
                if (currentDayTime == dayTime)
                {
                    [group.weeklyNews addObject:news];
                    isLastFlag = YES;
                }
                else
                {
                    //不在同一天,先把前面的组模型添加进来
                    if (!_showsNews)
                    {
                        self.showsNews = [NSMutableArray arrayWithCapacity:objects.count];
                    }
                    [self.showsNews addObject:group];
                    isLastFlag = NO;
                    
                    
                    dayTime = (NSInteger)timeInterval/(60*60*24);
                    group = [[WeeklyDayGroup alloc] init];
                    group.timeInterval = (NSTimeInterval)dayTime*60*60*24;
                    if (!group.weeklyNews)
                    {
                        group.weeklyNews = [NSMutableArray array];
                    }
                    
                    //添加元素
                    [group.weeklyNews addObject:news];
                }
            }
        }  //forin
        //如果是最后一组没记录，保存一下
        if (isLastFlag)
        {
            if (!_showsNews)
            {
                self.showsNews = [NSMutableArray arrayWithCapacity:objects.count];
            }
            [self.showsNews addObject:group];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            finish();
        });
    }];
}

@end
