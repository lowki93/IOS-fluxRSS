//
//  MasterViewController.m
//  fluxRss
//
//  Created by OBE Louise on 28/03/14.
//  Copyright (c) 2014 OBE Louise. All rights reserved.
//

#import "MasterViewController.h"

#import "XmlParser.h"
#import "DetailViewController.h"
#import "ModelArticle.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    XmlParser *parser;
}

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    parser = [[XmlParser alloc] init];
    [parser init:@"http://rss.lemonde.fr/c/205/f/3050/index.rss"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [parser.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imageView.image = nil;
    ModelArticle *myArticle = parser.articles[indexPath.row];

    UILabel *articleTitle = (UILabel *)[cell viewWithTag:101];
    articleTitle.text = myArticle.title;
    
    UILabel *articleDate = (UILabel *)[cell viewWithTag:102];
    articleDate.text = myArticle.date;
    
    // other methode
//    if (myArticle.image != nil)  {
//        cell.imageView.image = myArticle.image;
//        myArticle.image = nil;
//    } else {
//        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:myArticle];
//    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(queue, ^{
        id path = myArticle.imageUrl;
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *articleImg = (UIImageView *)[cell viewWithTag:100];
            articleImg.image = img;
        });
    });
 
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return  NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelArticle *myArticle = parser.articles[indexPath.row];
    self.detailViewController.url = myArticle.link;
    self.detailViewController.title = myArticle.title;
}

- (void)loadImage:(ModelArticle *)article
{
    NSURL *url = [NSURL URLWithString:article.imageUrl];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    article.image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:article waitUntilDone:NO];
}

- (void)updateCell:(ModelArticle *)article
{
    NSInteger row = [_objects indexOfObject:article];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
