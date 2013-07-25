//
//  ModalWebViewController.h
//  BrowserBenchmark
//
//  Created by FNSK on 13-6-21.
//  Copyright (c) 2013年 FNSK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface ModalWebViewController : UINavigationController

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL *)URL;

@property (nonatomic, strong) UIColor *barsTintColor;

@end
