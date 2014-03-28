//
//  ModelArticle.h
//  fluxRss
//
//  Created by BUDAIN Kevin on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelArticle : NSObject<NSXMLParserDelegate>

@property(nonatomic, retain)NSMutableArray *articles;

// methode pour recup le xml et le parser
-(void)init:(NSString*)url;
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;



@end
