//
//  ViewController.m
//  webViewPopBut
//
//  Created by dz on 15/10/8.
//  Copyright © 2015年 linfeng. All rights reserved.
//

#import "ViewController.h"
#import "ADWebTouchControl.h"
#import "XAssetsLibrary.h"

@interface ViewController ()
@property(nonatomic, strong)ADWebTouchControl           *webTouchControl;
@property (nonatomic, strong)WKWebView                  *kWebView;

@end

@implementation ViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        
     
    }
    return self;
}

- (void)webView:(UIWebView *)webView action:(NSInteger)action datas:(NSDictionary *)datas {
    NSLog(@"action: %ld  %@", (long)action,datas);
    __weak typeof(self) this = self;
    if (datas) {
        NSString *url = [datas objectForKey:@"url"];
        NSNumber *index = [datas objectForKey:@"index"];
        NSString *type = [datas objectForKey:@"type"];
        NSString *title = [datas objectForKey:@"title"];
        
        if ([type isEqualToString:@"link"]) {//link share
            switch (index.integerValue) {
                case 1:
//                    [this longpPressShare:url image:nil title:title];
                    break;
                case 2:{//copy
                    if (url) {
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        pasteboard.string = url;
                        
//                        [this showMessageWithTitle:APP_TR(@"TR_WEB_LP_TEXT1") hideDelay:2];//Copyed
                    }else{
//                        [this showMessageWithTitle:APP_TR(@"TR_WEB_LP_TEXT2") hideDelay:2];//CopyFail
                    }
                }
                    break;
                default:
                    break;
            }
        } else {//image share
            __block UIImage *__image = nil;
//            APP_REMIND_T(this, APP_TR(@"TR_WEB_LP_TEXT6"));
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                __image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (__image){
//                        APP_REMIND_HIDE(this, YES);
                        switch (index.integerValue) {
                            case 2:
//                                [this longpPressShare:url image:__image title:title];
                                break;
                            case 3: {
                                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                pasteboard.image = __image;
//                                APP_REMIND_TD(this, APP_TR(@"TR_WEB_LP_TEXT1"), 1);
                            }
                                break;
                            case 4:
                                [this saveImage:__image];
                                break;
                            default:
                                break;
                        }
                    }else{
//                         //获取失败，请重试
                    }
                });
            });
        }
    }
}

#pragma mark 长按分享事件
- (void)saveImage:(UIImage *)image{
    __weak typeof(self) this = self;
    [XAssetsLibrary saveImage:image
          withCompletionBlock:^(NSError *error) {
              NSString *result = @"";
              if (error == nil) {
                  result = @"successfil";
              }else{
                  result = @"failed";
              }
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"image save"
                                                                                       message:result
                                                                                preferredStyle:UIAlertControllerStyleAlert];
              [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    
                                                                }]];
              [this presentViewController:alertController animated:YES completion:^{}];

          }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    [controller addScriptMessageHandler:(id<WKScriptMessageHandler>)self name:@"web_observe"];
    configuration.userContentController = controller;
    
    _kWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _kWebView.allowsBackForwardNavigationGestures = YES;
    _kWebView.navigationDelegate = (id<WKNavigationDelegate>)self;
    _kWebView.UIDelegate = (id<WKUIDelegate>)self;
    _kWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    [self.view addSubview:_kWebView];
    [_kWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    __weak typeof(self) this = self;
    _webTouchControl = [[ADWebTouchControl alloc]initWithWebView:nil
                                                     orWKWebVIew:_kWebView
                                                 completionBlock:^(NSDictionary *rs) {
                                                     NSLog(@"网页附加行为: %@", rs);
                                                     NSInteger action = [[rs valueForKey:@"index"] integerValue];
                                                     [this webView:_kWebView action:action datas:rs];
                                                 }];
    _webTouchControl.webView = _kWebView;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    [_kWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
