//
//  ModelArticle.h
//  fluxRss
//
//  Created by BUDAIN Kevin on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelArticle : NSObject

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *link;
@property(nonatomic, retain) NSURL *imageUrl;
@property(nonatomic, retain) NSString *date;
@property(nonatomic, retain) UIImage *image;

@end