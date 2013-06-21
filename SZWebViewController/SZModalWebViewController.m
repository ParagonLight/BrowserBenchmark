//
//  SZModalWebViewController.m
//  BrowserBenchmark
//
//  Created by Zongxuan Su on 13-6-21.
//  Copyright (c) 2013年 Zongxuan Su. All rights reserved.
//

#import "SZModalWebViewController.h"
#import "SZWebViewController.h"

@interface SZModalWebViewController ()

@property (nonatomic, strong) SZWebViewController *webViewController;

@end


@implementation SZModalWebViewController

@synthesize barsTintColor, webViewController;

#pragma mark - Initialization


- (id)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL *)URL {
    self.webViewController = [[SZWebViewController alloc] initWithURL:URL];
    if (self = [super initWithRootViewController:self.webViewController]) {
        self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:webViewController action:@selector(doneButtonClicked:)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
    self.webViewController.title = self.title;
    self.navigationBar.tintColor = self.barsTintColor;
}

@end
