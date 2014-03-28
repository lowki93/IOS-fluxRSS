//
//  ModelArticle.m
//  fluxRss
//
//  Created by BUDAIN Kevin on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import "ModelArticle.h"

@implementation ModelArticle
{
    NSMutableString *ElementValue;
    NSMutableDictionary *item;
    NSString *currentElement;
}

@synthesize articles;

-(void)init:(NSString *)url
{
    NSURLResponse *rep = nil;
    NSError *err = nil;
    
    
    // on recupere l'url du xml pouvoir le parser
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse: &rep error: &err];
    NSXMLParser *rssParser=[[NSXMLParser alloc]initWithData:response];
    articles=[[NSMutableArray alloc] init];
    [rssParser setDelegate:self];
    [rssParser parse];
    NSLog(@"%d",[articles count]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [ElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = [elementName copy];
    ElementValue = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"item"])
    {
        // un élément début par article
        item = [[NSMutableDictionary alloc] init];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"item"])
    {
        [articles addObject:[item copy]];}
    else
    {
        [item setObject:ElementValue forKey:elementName];
    }
}

@end
