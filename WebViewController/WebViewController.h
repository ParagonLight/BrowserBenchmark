//
//  WebViewController.h
//  BrowserBenchmark
//
//  Created by FNSK on 13-6-21.
//  Copyright (c) 2013年 FNSK. All rights reserved.
//

#import "ModalWebViewController.h"

@interface WebViewController : UIViewController{
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
