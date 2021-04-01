//
//  ViewController.m
//  HomeAssignmentObjectiveC
//
//  Created by Olga Rudina on 2021-03-31.
//

#import "HomeScreenController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PostCell.h"
#import "PostModel.h"
#import <SDWebImage/SDWebImage.h>
#import <AVFoundation/AVFoundation.h>
#import "HomeAssignmentObjectiveC-Swift.h"

@interface HomeScreenController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *postsArray;
@property (nonatomic, strong) NSMutableDictionary<NSIndexPath*, UIImage*> *cache;
@property (weak, nonatomic) PostCell *postCell;
@property (nonatomic, strong) UIImage *selectedPostImage;

@end

@implementation HomeScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil]
       forCellReuseIdentifier:@"postCell"];
    [self.tableView setDelegate: self];
    [self.tableView setDataSource: self];
    [self getDataFromJson];
    self.cache = [[NSMutableDictionary alloc] init];
}

//TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.postsArray.count;//number rows you want in table
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"postCell";

    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PostCell alloc]initWithStyle:
        UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PostModel *post = self.postsArray[indexPath.row];
    cell.titleLabel.text = post.title;
    cell.likeLabel.text = [NSString stringWithFormat:@"%C", 0xf004];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%C", 0xf086];
    cell.numberOfCommentsLabel.text = [NSString stringWithFormat:@"%@", post.numComments];
    cell.upvotesLabel.text = [NSString stringWithFormat:@"%@", post.upvotes];
    cell.postImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.postImage.image = nil;
    [cell.postImage setHidden: YES];
    
    UIImage *cahedImage = [self.cache objectForKey:indexPath];
    
    //Fetching image from URL
    if (!cahedImage) {
        [cell.postImage sd_setImageWithURL:[NSURL URLWithString: post.imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
            if (image) {
                [self.cache setObject:image forKey:indexPath];
                [cell.postImage setHidden: NO];
                cell.imageHeight.constant = AVMakeRectWithAspectRatioInsideRect(image.size, self.view.bounds).size.height;
                //check if tableview is onscreen, otherwise may cause warning
                if (tableView.window != nil)
                {
                [self.tableView beginUpdates];
                [self.tableView endUpdates];
                };
            } else {
                [self.cache setObject:[[UIImage alloc] init] forKey:indexPath];
                [cell.postImage setHidden: YES];
                cell.imageHeight.constant = 0.0;
                if (tableView.window != nil)
                {
                [self.tableView beginUpdates];
                [self.tableView endUpdates];
                };}
        }];
    } else {
        cell.postImage.image = cahedImage;
        [cell.postImage setHidden: NO];
        
        if (cahedImage.size.height > 0.0) {
            cell.imageHeight.constant = AVMakeRectWithAspectRatioInsideRect(cahedImage.size, self.view.bounds).size.height;
        } else {
            cell.imageHeight.constant = 0.0;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 700;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedPostImage = [self.cache objectForKey:indexPath];
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}

//Networking Methods

-(void) getDataFromJson{
    
    NSURL *url = [NSURL URLWithString: @"https://www.reddit.com/.json"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
       NSError *err;
       NSArray *redditFeed = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if(err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *postsList = [[NSMutableArray alloc] init];
            
            for (NSDictionary *post in [redditFeed valueForKeyPath:@"data.children.data"]) {
                PostModel *item = [[PostModel alloc] init];
                item.title = [post valueForKey:@"title"];
                item.desc = [post valueForKey:@"selftext"];
                item.upvotes = [post valueForKey:@"score"];
                item.imageURL = [post valueForKey:@"url_overridden_by_dest"];
                item.numComments = [post valueForKey:@"num_comments"];
                [postsList addObject: item];
            }
            
            self.postsArray = postsList;
        
            [self.tableView layoutIfNeeded];
            [self.tableView reloadData];
        });
    }] resume];
}


//Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetails"])
    {
        DetailScreenController *vc = [segue destinationViewController];
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        vc.post = self.postsArray[row];
        vc.selectedPostImage = self.selectedPostImage;
    }
}

@end
