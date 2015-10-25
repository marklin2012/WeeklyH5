//
//  InfoViewController.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/25.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "InfoViewController.h"
#import "FAKFontAwesome.h"
#import "AVOSCloudSNS.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1;
    
    FAKFontAwesome *icon = [FAKFontAwesome qqIconWithSize:15];
    [self.loginBtn setImage:[icon imageWithSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender
{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:QQAppKey andAppSecret:QQAppSecret andRedirectURI:QQRedirectURI];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error)
        {
            
        }
        else
        {
//            NSString *accessToken = object[@"access_token"];
//            NSString *username = object[@"username"];
//            NSString *avatar = object[@"avatar"];
//            NSDictionary *rawUser = object[@"raw-user"]; // 
        }
    } toPlatform:AVOSCloudSNSQQ];
}


@end
