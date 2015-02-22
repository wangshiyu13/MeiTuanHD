//
//  DetailViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//
#import <PureLayout.h>
#import <UIImageView+WebCache.h>
#import "MBProgressHUD+MJ.h"
#import <MJExtension.h>

#import "DetailViewController.h"

#import "DPAPI.h"
#import "Deal.h"
#import "DealTool.h"
#import "GetSingleDealResult.h"

#define HTMLFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.html", self.deal.deal_id]]
#define LastUrlPath webView.request.URL.absoluteString
@interface DetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *soldNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefuntableButton;
@property (weak, nonatomic) IBOutlet UIButton *expiresRefuntableButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@end

@implementation DetailViewController
#pragma mark - 懒加载
- (UIActivityIndicatorView *)loadingView {
    if (_loadingView == nil) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.webView addSubview:loadingView];
        [loadingView autoCenterInSuperview];
        _loadingView = loadingView;
    }
    return _loadingView;
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDetailView];
    [self setupWebView];
    
    // 添加团购到访问记录
    [DealTool addHistoryDeal:self.deal];
}

#pragma mark - 初始化方法
- (void)setupDetailView {
    // 收藏按钮
    self.collectButton.selected = [DealTool isCollected:self.deal];
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    // 标题
    self.titleLabel.text = self.deal.title;
    // 描述
    self.descLabel.text = self.deal.desc;
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥%@", self.deal.list_price];
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@", self.deal.current_price];
    // 购买数
    [self.soldNumberButton setTitle:[NSString stringWithFormat:@"已售出%d份", self.deal.purchase_count] forState:UIControlStateNormal];
    // 剩余时间
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [calender components:unit fromDate:[NSDate date] toDate:self.deal.purchase_deadline options:kNilOptions];
    if (cmps.day >= 365) {
        [self.leftTimeButton setTitle:@"未来一年内有效" forState:UIControlStateNormal];
    } else {
        [self.leftTimeButton setTitle:[NSString stringWithFormat:@"剩余%d天%d小时%d分", cmps.day, cmps.hour, cmps.minute]forState:UIControlStateNormal];
    }
    // 发送请求给服务器获得更详细的团购信息
    NSDictionary *params = @{@"deal_id" : self.deal.deal_id};
    [[DPAPI sharedInstance] request:@"v1/deal/get_single_deal" params:params success:^(id json) {
        GetSingleDealResult *result = [GetSingleDealResult objectWithKeyValues:json];
        Deal *subDeal = [result.deals firstObject];
        self.anyTimeRefuntableButton.selected = !subDeal.is_refundable;
        self.expiresRefuntableButton.selected = !subDeal.is_refundable;
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"阿西吧"];
    }];
}

- (void)setupWebView {
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.loadingView startAnimating];
    self.webView.scrollView.hidden = YES;
    // 先尝试加载本地的html文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:HTMLFilePath]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:HTMLFilePath]]];
    } else { // 如果没有则从网络加载
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    }
}

#pragma mark - <UIWebViewDelegate>
/**
 *  webView加载完毕时调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([LastUrlPath hasPrefix:@"file"]) {
        self.webView.scrollView.hidden = NO;
        [self.loadingView stopAnimating];
    } else {
        if ([LastUrlPath isEqualToString:self.deal.deal_h5_url]) {
            // 加载详情
#warning 修改截取字符串的方法，更好的适应网页变化
            NSRange range = [self.deal.deal_id rangeOfString:@"-"];
            NSString *ID = [self.deal.deal_id substringFromIndex:range.location + 1];
            NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        } else {
            // 加载详情成功
            // 执行JS
            NSString *js = @"document.getElementsByTagName('header')[0].remove();"
            "document.getElementsByClassName('cost-box')[0].remove();"
            "document.getElementsByClassName('buy-now')[0].remove();";
            [webView stringByEvaluatingJavaScriptFromString:js];
            self.webView.scrollView.hidden = NO;
            NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
            
            NSError *error = nil;
            [html writeToFile:HTMLFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            [self.loadingView stopAnimating];
            if (error) [MBProgressHUD showError:[NSString stringWithFormat:@"本地缓存失败！\n错误信息：\n%@", error]];
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - 监听按钮点击
- (IBAction)backBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)collect:(UIButton *)sender {
    if (sender.isSelected) {
        [DealTool uncollect:self.deal];
    } else {
        [DealTool collect:self.deal];
    }
    sender.selected = !sender.isSelected;
    sender.selected ? [MBProgressHUD showSuccess:@"已收藏"] : [MBProgressHUD showError:@"已取消收藏"];
}

#pragma mark - 设置当前控制器支持哪些方向
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
@end
