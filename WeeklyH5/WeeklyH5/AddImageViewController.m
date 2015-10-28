//
//  AddImageViewController.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/25.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "AddImageViewController.h"

NSString *const AddImageViewControllerCatchImageNotify = @"AddImageViewControllerCatchImageNotify";

@interface AddImageViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AddImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView setScalesPageToFit:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(catchImage)];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.webView.delegate = nil;
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
}

- (void)catchImage
{
    UIImage *image = [self snapshot:_webView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AddImageViewControllerCatchImageNotify object:image];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
