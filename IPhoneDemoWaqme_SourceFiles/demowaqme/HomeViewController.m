//
//  HomeViewController.m
//  demowaqme
//
//  Created by Bilal Nasir on 02/09/2014.
//  Copyright (c) 2014 axonshare. All rights reserved.
//

#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


NSString* chk=@"0";
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:YES];
    
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)  {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Waqme" message:@"Internet is not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
        
    }
    else
    {
        float width = self.view.bounds.size.width;
        float height = self.view.bounds.size.height;
        UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0.0,20.0, width, height-20.0)];
        wv.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        wv.backgroundColor = [UIColor clearColor];
        wv.delegate = self;
        NSString *urlAddress=@"";
        urlAddress = [NSString stringWithFormat:@"http://demowaqme.akshoping.com/welcome.html"];
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [wv loadRequest:requestObj];
        [self.view addSubview:wv];
    }
    
}

#pragma mark - Optional UIWebViewDelegate delegate methods

- (BOOL)wv:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (BOOL)webView:(UIWebView*)wv shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)wv
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if ([chk isEqualToString:@"0"])
    {
    
    [self setIndicatorView:[MBProgressHUD showHUDAddedTo:self.view animated:YES]];
    chk=@"1";
        
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)wv
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.indicatorView hide:YES];
    [self setIndicatorView:nil];
    [self.indicatorView hide:YES];
    [self setIndicatorView:nil];
}







@end
