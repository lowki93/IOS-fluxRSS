//
//  XmlParser.m
//  fluxRss
//
//  Created by BUDAIN Kevin on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import "XmlParser.h"

@implementation XmlParser
{
     NSMutableString *ElementValue;
}

@synthesize articles, article;


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


}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
        [ElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
        ElementValue = [[NSMutableString alloc] init];
        if ([elementName isEqualToString:@"item"])
        {
            // un élément début par article
            article = [[ModelArticle alloc]init];
            
             [articles addObject:article];
        } else if ([elementName isEqualToString:@"title"]) {
            article.title = ElementValue;
        } else if ([elementName isEqualToString:@"link"]) {
            article.link = ElementValue;
        } else if([elementName isEqualToString:@"enclosure"]){
            article.imageUrlString = attributeDict[@"url"];
        } if ([elementName isEqualToString:@"pubDate"]) {
            article.dateString = ElementValue;
        }
}

@end