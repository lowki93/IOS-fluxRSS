//
//  DetailViewController.h
//  fluxRss
//
//  Created by OBE Louise on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property(nonatomic, strong) NSString *url;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
