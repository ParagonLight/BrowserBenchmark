//
//  SZWebViewController.h
//  BrowserBenchmark
//
//  Created by Zongxuan Su on 13-6-21.
//  Copyright (c) 2013年 Zongxuan Su. All rights reserved.
//

#import "SZModalWebViewController.h"

@interface SZWebViewController : UIViewController{
    int offset1;
    int times1;
    double interval1;
    double speed1;
    int offset2;
    int times2;
    double interval2;
    double speed2;
    int currentOffset;
    int idleInterval;
    int idleTimes;
    int times;
}


- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

@end
