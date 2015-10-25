//
//  ScanViewController.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/24.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "ScanViewController.h"
#import "AddNewsViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //为扫描页面至添加页面的跳转时
    if ([segue.identifier isEqualToString:@"scanToAdd"])
    {
        AddNewsViewController *addCtl = (AddNewsViewController *)segue.destinationViewController;
        addCtl.urlString = ScanURI;
    }
}



@end
