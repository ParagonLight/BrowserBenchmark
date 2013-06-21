//
//  SZViewController.m
//  BrowserBenchmark
//
//  Created by Zongxuan Su on 13-6-21.
//  Copyright (c) 2013年 Zongxuan Su. All rights reserved.
//

#import "SZViewController.h"
#import "SZModalWebViewController.h"

@interface SZViewController ()

@end

@implementation SZViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)browser:(id)sender
{
	NSURL *URL = [NSURL URLWithString:@"http://www.apple.com"];
	SZModalWebViewController *webViewController = [[SZModalWebViewController alloc] initWithURL:URL];
	webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
	[self presentViewController:webViewController animated:YES completion:nil];
}

@end
