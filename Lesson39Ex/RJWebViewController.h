//
//  RJWebViewController.h
//  Lesson39Ex
//
//  Created by Hopreeeeenjust on 09.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJWebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSURLRequest *urlRequest;
@property (strong, nonatomic) UIBarButtonItem *goForward;
@property (strong, nonatomic) UIBarButtonItem *goBack;
@end
