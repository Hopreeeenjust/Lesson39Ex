//
//  ViewController.m
//  Lesson39Ex
//
//  Created by Hopreeeeenjust on 09.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "ViewController.h"
#import "RJWebViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *fileTypesArray;
@property (strong, nonatomic) NSArray *urlsArray;
@property (strong, nonatomic) NSArray *filesArray;
@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *urlStringsArray = @[@"http://onliner.by", @"http://apple.com", @"http://vk.com"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *urlString in urlStringsArray) {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [tempArray addObject:request];
    }
    self.urlsArray = tempArray;
    
    NSArray *pdfFilesArray = @[@"Football", @"Tickets", @"Apple", @"C language"];
    NSMutableArray *anotherTempArray = [NSMutableArray array];
    for (NSString *pdfFileName in pdfFilesArray) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:pdfFileName withExtension:@"pdf"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [anotherTempArray addObject:request];
    }
    self.filesArray = anotherTempArray;
    
    self.fileTypesArray = [NSArray new];
    self.fileTypesArray = @[self.urlsArray, self.filesArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fileTypesArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"URLs";
    } else {
        return @"PDF Files";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fileTypesArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSURLRequest *request = [[self.fileTypesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSURL *url = [request URL];
    NSString *filePrefix = @"file:/";
    if ([[url absoluteString] hasPrefix:filePrefix]) {
        cell.textLabel.text = [url lastPathComponent];
    } else {
        cell.textLabel.text = [url absoluteString];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RJWebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJWebViewController"];
    vc.title = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSURLRequest *request = [[self.fileTypesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    vc.urlRequest = request;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
