//
//  ModalWebViewController.m
//  BrowserBenchmark
//
//  Created by FNSK on 13-6-21.
//  Copyright (c) 2013年 FNSK. All rights reserved.
//

#import "ModalWebViewController.h"
#import "WebViewController.h"

@interface ModalWebViewController ()

@property (nonatomic, strong) WebViewController *webViewController;

@end


@implementation ModalWebViewController

@synthesize barsTintColor, webViewController;

#pragma mark - Initialization


- (id)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL *)URL {
    self.webViewController = [[WebViewController alloc] initWithURL:URL];
    if (self = [super initWithRootViewController:self.webViewController]) {
        //self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:webViewController action:@selector(doneButtonClicked:)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
    self.webViewController.title = self.title;
    self.navigationBar.tintColor = self.barsTintColor;
}

@end
