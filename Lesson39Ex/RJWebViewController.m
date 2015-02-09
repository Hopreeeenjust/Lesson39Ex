//
//  RJWebViewController.m
//  Lesson39Ex
//
//  Created by Hopreeeeenjust on 09.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJWebViewController.h"

@implementation RJWebViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *goForward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(actionGoForward:)];
    self.goForward = goForward;
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(actionGoBack:)];
    self.goBack = goBack;
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionRefresh:)];
    self.navigationItem.rightBarButtonItems = @[goForward, refresh, goBack];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:self.urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions 

- (void)actionGoBack:(UIBarButtonItem *)sender {
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (void)actionGoForward:(UIBarButtonItem *)sender {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

- (void)actionRefresh:(UIBarButtonItem *)sender {
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self refreshButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    [self refreshButtons];
}

- (void)refreshButtons {
    self.goBack.enabled = [self.webView canGoBack];
    self.goForward.enabled = [self.webView canGoForward];
}

@end
