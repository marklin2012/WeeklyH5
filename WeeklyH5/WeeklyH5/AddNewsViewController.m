//
//  AddNewsViewController.m
//  WeeklyH5
//
//  Created by MarkLin on 15/10/24.
//  Copyright © 2015年 www.aoyolo.com艾悠乐网络. All rights reserved.
//

#import "AddNewsViewController.h"
#import "WeeklyNews.h"
#import "ProgressHUD.h"
#import "WeeklyManager.h"
#import "RatingBar.h"
#import "AddImageViewController.h"

@interface AddNewsViewController ()<UIWebViewDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textvView;
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *savBtn;

@property (nonatomic, strong) RatingBar *createRating;
@property (nonatomic, strong) RatingBar *sightRating;
@property (nonatomic, strong) RatingBar *tecRating;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIButton *addImageBtn;
@property (nonatomic) CGFloat addImageWidth;
@property (nonatomic) CGFloat addImageHeight;



@end

@implementation AddNewsViewController
{
    UITextView *_showTextView;
    UITextField *_showField;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initScrollView];
    [self _initHeadView];
    [self loadData];
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(catchImage:) name:AddImageViewControllerCatchImageNotify object:nil];
}

- (void)loadData
{
    [ProgressHUD show:@"读取网页数据中，请稍候"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)_initScrollView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.textvView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textvView.layer.borderWidth = 1;
    
    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textField.layer.borderWidth = 1;
    
    self.ratingView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ratingView.layer.borderWidth = 1;
    
    self.savBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.savBtn.layer.borderWidth = 1;
    
    CGRect rect = _createRating.frame;
    self.createRating = [[RatingBar alloc] initWithFrame:rect];
    
    
    //   8   34     60
    self.createRating = [[RatingBar alloc] initWithFrame:CGRectMake(55, 8, 100, 20)];
    self.createRating.starNumber = 5;
    [self.ratingView addSubview:_createRating];
    
    self.sightRating = [[RatingBar alloc] initWithFrame:CGRectMake(55, 34, 100, 20)];
    self.sightRating.starNumber = 5;
    [self.ratingView addSubview:_sightRating];
    
    self.tecRating = [[RatingBar alloc] initWithFrame:CGRectMake(55, 60, 100, 20)];
    self.tecRating.starNumber = 5;
    [self.ratingView addSubview:_tecRating];
    
}

- (void)onTap
{
    [self.view endEditing:YES];
}

#pragma mark - headView
- (void)_initHeadView
{
    
    //计算宽高
    //最多三张图片，减去两边和中间两个间隙，获得宽度
    self.addImageWidth = (ScreenWidth - HeadImageGap*4)/3;
    //8:3  height/width = 3/8
    self.addImageHeight = 3 * (ScreenWidth - HeadImageGap * 2)/ 8;
    
    self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addImageBtn.frame = CGRectMake(0, 0, _addImageWidth, 50);
    [self.addImageBtn setImage:[UIImage imageNamed:@"photo_take"] forState:UIControlStateNormal];
    [self.addImageBtn addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_addImageBtn];
    
    
}

- (void)addImageAction:(UIButton *)button
{
    [self performSegueWithIdentifier:@"addImage" sender:nil];
}


- (void)refreshHeadView
{
    [self.images enumerateObjectsUsingBlock:^(UIImage*  image, NSUInteger idx, BOOL *stop) {
       
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + (_addImageWidth + HeadImageGap) * idx, 0, _addImageWidth, _addImageHeight)];
        
        imageView.image = image;
        [self.headerView addSubview:imageView];
    }];
    
    CGRect rect = _addImageBtn.frame;
    rect.origin.x = (_addImageWidth + HeadImageGap) * _images.count;
    self.addImageBtn.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardRect = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘动画时间
    NSTimeInterval duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat offset = 0;
        if (_showField)
        {
            offset =  (_showField.frame.origin.y+_showField.frame.size.height) - (ScreenHeight - keyboardRect.size.height-64);
        }
        else
        {
            offset =  (_showTextView.frame.origin.y+_showTextView.frame.size.height+10) - (ScreenHeight - keyboardRect.size.height-64);
            
        }
        self.scrollTopConstraint.constant = - ABS(offset);
    }];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    //获取键盘动画时间
    NSTimeInterval duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.scrollTopConstraint.constant = 0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            _showTextView = nil;
            _showField = nil;
        }
    }];
}

- (void)catchImage:(NSNotification *)note
{
    UIImage *image = note.object;
    if (!_images)
    {
        self.images = [NSMutableArray arrayWithCapacity:3];
    }
    [self.images addObject:image];
    [self refreshHeadView];
}

#pragma mark - xibAction

- (IBAction)savingAction:(UIButton *)sender
{
    if (_images.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"请至少添加一张图片" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        [ProgressHUD show:@"正在保存数据, 请稍候"];
        NSMutableArray *imageURLs = [NSMutableArray arrayWithCapacity:3];
        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(globalQueue, ^{
            //声明一个队列组
            dispatch_group_t group = dispatch_group_create();
            
            for (UIImage *image in _images)
            {
                dispatch_group_async(group, globalQueue, ^{
                    NSData *data = UIImageJPEGRepresentation(image, 1);
                    AVFile *file = [AVFile fileWithName:@"image.png" data:data];
                    NSError *error = nil;
                    [file save:&error];
                    
                    if (!error)
                    {
                        NSLog(@"上传成功，%@", file.url);
                        [imageURLs addObject:file.url];
                    }
                });
            }
            //监听调度完成后的任务
            dispatch_group_notify(group, globalQueue, ^{
                
                [self saveNewsWithImageURLs:imageURLs];
                
            });
        });
    }
}


- (void)saveNewsWithImageURLs:(NSArray *)imageURLs
{
    WeeklyNews *news = [WeeklyNews object];
    news.title = _textField.text;
    news.content = _textvView.text;
    news.images = imageURLs;
    [news saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [ProgressHUD showSuccess:@"保存成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

- (IBAction)categoryAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //通过webView读取数据解析html页面头部的内容
    self.textField.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.textvView.text = [webView stringByEvaluatingJavaScriptFromString:@"var a =document.head.getElementsByTagName('meta');var c;for(i=0;i< a.length;i++){var b = a[i];if (b.name == 'description'){c = b.content;}}"];
//    self.textvView.text = [webView stringByEvaluatingJavaScriptFromString:@"c"];
    
    [ProgressHUD showSuccess:@"网络数据加载完成"];
    
    webView.delegate = nil;
    [webView stopLoading];
    [webView removeFromSuperview];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _showTextView = textView;
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _showField = textField;
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addImage"])
    {
        AddImageViewController *imgCtl = segue.destinationViewController;
        imgCtl.urlString = _urlString;
    }
}


@end
