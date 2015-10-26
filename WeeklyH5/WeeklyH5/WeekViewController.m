//
//  ViewController.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/23.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "WeekViewController.h"
#import "WeeklyCell.h"
#import "WeeklyNews.h"
#import "WeeklyManager.h"
#import "WeeklyDayGroup.h"
#import "FAKFontAwesome.h"
#import "ProgressHUD.h"

@interface WeekViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation WeekViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WeeklyCell" bundle:nil]forCellReuseIdentifier:@"WeeklyCell"];
//    self.tableView.rowHeight = 275;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 275;
    
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:250/255.0 green:0/255.0 blue:66/255.0 alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [ProgressHUD show:@"加载数据中，请稍候"];
    [[WeeklyManager shareInstance] loadDatasWithFinishLoading:^{
        
        [ProgressHUD dismiss];
        [self.tableView reloadData];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"refresh" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable
{
    [[WeeklyManager shareInstance] loadDatasWithFinishLoading:^{
        
        [ProgressHUD dismiss];
        [self.tableView reloadData];
        
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [WeeklyManager shareInstance].showsNews.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WeeklyDayGroup *group = [WeeklyManager shareInstance].showsNews[section];
    return group.weeklyNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeeklyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeeklyCell"];
    
    WeeklyDayGroup *group = [WeeklyManager shareInstance].showsNews[indexPath.section];
    WeeklyNews *news = group.weeklyNews[indexPath.row];
    
    [cell configCellWithWeeklyNews:news andIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
