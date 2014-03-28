//
//  DetailViewController.m
//  fluxRss
//
//  Created by OBE Louise on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
@end

@implementation DetailViewController


#pragma mark - Managing the detail item


-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        
        _url = url;
        [self configureView];
    }
    
     if (self.masterPopoverController != nil) {
          [self.masterPopoverController dismissPopoverAnimated:YES];
      }
}
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.url) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.myWebView  loadRequest:requestObj];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.url = @"http://www.lemonde.fr";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
   barButtonItem.title = NSLocalizedString(@"Liste", @"Liste");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
