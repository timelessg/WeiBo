//
//  WBWebAuthViewController.m
//  Toshow
//
//  Created by Garry on 15/7/4.
//  Copyright (c) 2015年 FAN LING. All rights reserved.
//

#import "WBWebAuthViewController.h"
#import <BlocksKit+UIKit.h>

@interface WBWebAuthViewController () <UIWebViewDelegate>

@end

@implementation WBWebAuthViewController
{
    UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 48, kSCREENWIDTH, KSCREENHEIGHT - 48)];
    NSString *url = @"https://api.weibo.com/oauth2/authorize?client_id=2159567536&redirect_uri=http://sns.whalecloud.com/sina2/callback&response_type=code&display=mobile";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [webView setDelegate:self];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)_webView
{
    NSString *url = _webView.request.URL.absoluteString;
    
    if ([url hasPrefix:@"http://sns.whalecloud.com/sina2/callback"]) {
        
        NSRange rangeOne;
        rangeOne = [url rangeOfString:@"code="];
        
        NSRange range = NSMakeRange(rangeOne.length+rangeOne.location, url.length-(rangeOne.length+rangeOne.location));
        NSString *codeString = [url substringWithRange:range];
        
        NSMutableString *muString = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/oauth2/access_token?client_id=2159567536&client_secret=dcddfc2702919e60a2ceb86c23c31122&grant_type=authorization_code&redirect_uri=http://sns.whalecloud.com/sina2/callback&code="];
        [muString appendString:codeString];
        
        NSURL *urlstring = [NSURL URLWithString:muString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSData *data = [@"type=focus-c" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSError *error;
        NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:&error];
        WBUser *user = [WBUser new];
        user = [WBUser mj_objectWithKeyValues:infoDic];
        [self dismissViewControllerAnimated:YES completion:^{
            webView = nil;
            if (!error) {
                self.returnAuthInfo(user);
            }else{
                self.returnAuthInfo(nil);
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
