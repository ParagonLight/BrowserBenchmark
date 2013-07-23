//
//  SZWebViewController.h
//  BrowserBenchmark
//
//  Created by Zongxuan Su on 13-6-21.
//  Copyright (c) 2013年 Zongxuan Su. All rights reserved.
//

#import "SZWebViewController.h"

@interface SZWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *autoScrollButtonItem;
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITextField *urlTextField;

@property (nonatomic, strong) NSMutableDictionary *plistDict;

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;
- (void)loadURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;
- (void)autoScrollClicked:(UIBarButtonItem *)sender;

@end


@implementation SZWebViewController


@synthesize URL, mainWebView;
@synthesize backBarButtonItem, forwardBarButtonItem, refreshBarButtonItem, stopBarButtonItem, autoScrollButtonItem;
@synthesize myTimer;
@synthesize plistDict;

#pragma mark - setters and getters

- (UIBarButtonItem *)autoScrollButtonItem {
    if (!autoScrollButtonItem){
        autoScrollButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting.png"] style:UIBarButtonItemStylePlain target:self action:@selector(autoScrollClicked:)];
        autoScrollButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		autoScrollButtonItem.width = 18.0f;
    }
    return autoScrollButtonItem;
}

- (UIBarButtonItem *)backBarButtonItem {
    
    if (!backBarButtonItem) {
        backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SZWebViewController.bundle/back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		backBarButtonItem.width = 18.0f;
    }
    return backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!forwardBarButtonItem) {
        forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SZWebViewController.bundle/forward"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		forwardBarButtonItem.width = 18.0f;
    }
    return forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!refreshBarButtonItem) {
        refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
    }
    
    return refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!stopBarButtonItem) {
        stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
    }
    return stopBarButtonItem;
}

- (void)setURL:(NSURL *)aURL
{
	URL = aURL;
	self.urlTextField.text = URL.absoluteString;
}

- (NSURL *)URL
{
	NSString *text = self.urlTextField.text;
	NSString *autocompletedText = [text hasPrefix:@"http://"]?text:[NSString stringWithFormat:@"http://%@", text];
	self.URL = [NSURL URLWithString:autocompletedText];
	return URL;
}

- (UITextField *)urlTextField
{
	if (!_urlTextField) {
		_urlTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 310, 24)];
		_urlTextField.placeholder = @"Enter web address here...";
		_urlTextField.clearsOnBeginEditing = YES;
		_urlTextField.keyboardType = UIKeyboardTypeURL;
		_urlTextField.returnKeyType = UIReturnKeyGo;
		[_urlTextField addTarget:self action:@selector(urlInputed) forControlEvents:UIControlEventEditingDidEndOnExit];
	}
	return _urlTextField;
}

- (void)urlInputed
{
	[self loadURL:self.URL];
}

- (UIView *)maskView
{
	if (!_maskView) {
		_maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
	}
	return _maskView;
}


#pragma mark - Initialization

- (id)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL*)pageURL {
    
    if(self = [super init]) {
        self.URL = pageURL;
    }
    
    return self;
}

- (void)loadURL:(NSURL *)pageURL {
    [mainWebView loadRequest:[NSURLRequest requestWithURL:pageURL]];
}

#pragma mark - View lifecycle

- (void)loadView {
    mainWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    [self loadURL:self.URL];
    self.view = mainWebView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    [self readPListFile];
	self.maskView.backgroundColor = [UIColor whiteColor];
	[self.navigationController.view addSubview:self.maskView];
	self.urlTextField.backgroundColor = [UIColor whiteColor];
	self.urlTextField.textAlignment = NSTextAlignmentCenter;
	[_maskView addSubview:self.urlTextField];
    [self updateToolbarItems];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    mainWebView = nil;
    backBarButtonItem = nil;
    forwardBarButtonItem = nil;
    refreshBarButtonItem = nil;
    stopBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)dealloc
{
    [mainWebView stopLoading];
 	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    mainWebView.delegate = nil;
}

#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled = self.mainWebView.canGoForward;
    self.autoScrollButtonItem.enabled = YES;
    UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 5.0f;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	NSArray *items;
	
	items = [NSArray arrayWithObjects:
			 flexibleSpace,
			 self.backBarButtonItem,
			 flexibleSpace,
			 self.forwardBarButtonItem,
			 flexibleSpace,
             self.autoScrollButtonItem,
             flexibleSpace,
			 refreshStopBarButtonItem,
			 flexibleSpace,
			 nil];
	
	self.navigationController.toolbar.barStyle = self.navigationController.navigationBar.barStyle;
	self.navigationController.toolbar.tintColor = self.navigationController.navigationBar.tintColor;
	self.toolbarItems = items;
    
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"window.location"]);
    [self updateToolbarItems];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self updateToolbarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateToolbarItems];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	self.URL = request.URL;
	return YES;
}

#pragma mark - Target actions

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [mainWebView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [mainWebView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [mainWebView reload];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    [mainWebView stopLoading];
	[self updateToolbarItems];
}

- (void)autoScrollClicked:(UIBarButtonItem *)sender {
    //scroll down
    interval1 = [[[plistDict valueForKey:@"first"] valueForKey:@"interval"] doubleValue];
    offset1 = [[[plistDict valueForKey:@"first"] valueForKey:@"offset"] integerValue];
    speed1 = [[[plistDict valueForKey:@"first"] valueForKey:@"speed"] doubleValue];
    times1 = [[[plistDict valueForKey:@"first"] valueForKey:@"times"] integerValue];
    //scroll up
    interval2 = [[[plistDict valueForKey:@"second"] valueForKey:@"interval"] doubleValue];
    offset2 = [[[plistDict valueForKey:@"second"] valueForKey:@"offset"] integerValue];
    speed2 = [[[plistDict valueForKey:@"second"] valueForKey:@"speed"] doubleValue];
    times2 = [[[plistDict valueForKey:@"second"] valueForKey:@"times"] integerValue];
    
    //idle
    idleInterval = [[[plistDict valueForKey:@"idle"] valueForKey:@"interval"] doubleValue];
    idleTimes = [[[plistDict valueForKey:@"idle"] valueForKey:@"times"] doubleValue];
    currentOffset = 0;
    times = 0;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:interval1 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)autoScroll {
    if(times < times1){
        currentOffset += offset1 / 2;
        if ([mainWebView subviews]) {
            UIScrollView* scrollView = [[mainWebView subviews] objectAtIndex:0];
            [UIView animateWithDuration:speed1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [scrollView setContentOffset:CGPointMake(0, currentOffset) animated:YES];
                times ++;
            } completion:nil];
        }
    }else if(times >= (times1) && times < (idleTimes + times1)){
        //do nothing
        times ++;
    }else if(times >= (idleTimes +times1) && times < (idleTimes + times2 + times1)){
        currentOffset += offset2 / 2;
        if ([mainWebView subviews]) {
            UIScrollView* scrollView = [[mainWebView subviews] objectAtIndex:0];
            [UIView animateWithDuration:speed2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [scrollView setContentOffset:CGPointMake(0, currentOffset) animated:YES];
                times ++;
            } completion:nil];
        }
    }else{
        [myTimer invalidate];
        myTimer = nil;
    }
}


- (void)doneButtonClicked:(id)sender {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    [self dismissModalViewControllerAnimated:YES];
#else
    [self dismissViewControllerAnimated:YES completion:NULL];
#endif
}

#pragma mark - Read pList

- (void) readPListFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"schedule" ofType:@"plist"];
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
}


@end
