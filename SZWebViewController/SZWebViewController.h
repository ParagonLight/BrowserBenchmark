//
//  SZWebViewController.h
//  BrowserBenchmark
//
//  Created by Zongxuan Su on 13-6-21.
//  Copyright (c) 2013年 Zongxuan Su. All rights reserved.
//

#import "SZModalWebViewController.h"

@interface SZWebViewController : UIViewController

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

@end
