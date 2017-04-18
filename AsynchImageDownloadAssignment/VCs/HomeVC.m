//
//  HomeVC.m
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import "HomeVC.h"
#import "ImageInfoCell.h"
#import "SVPullToRefresh.h"

@interface HomeVC ()


@end

@implementation HomeVC

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
     self.tbl_ImagesList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addRefreshControl];
    [self fetchJsonResponseFromServer];
    
}


-(void)fetchJsonResponseFromServer
{
    [[NetworkLayer sharedNetworkLayer]getResponseWithSourceObject:self WithApiEndPoint:@"" WithParams:nil];
}


#pragma mark-pull to refresh Methods

- (IBAction)addRefreshControl
{
    
    refreshControll = [[UIRefreshControl alloc]init];
    [self.tbl_ImagesList addSubview:refreshControll];
    [refreshControll addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    // here we are adding paging option , its a scrollview category that provides us this functionality.
    
    [self.tbl_ImagesList addInfiniteScrollingWithActionHandler:^{
        [self bottomPullToRefreshTriggered];
        // self.title = @"Loading";
        
    }];
    
}

- (void)bottomPullToRefreshTriggered
{
    [self.tbl_ImagesList.infiniteScrollingView stopAnimating];
    if(tagForScroll < 1)
    {
        [self refreshTable];
        return;
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self fetchJsonResponseFromServer];
   // [refreshControll endRefreshing];
   
    
}

- (void)refreshTable
{
    // In refreshing data removing cachy and fetch new data.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self fetchJsonResponseFromServer];
    [refreshControll endRefreshing];
}

#pragma mark - TableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BaseClass *baseClassObj = [dataArray objectAtIndex:indexPath.row];
   float cellHeight =[Utililities getImageHeightAccordingToAspectRatio:baseClassObj.width WithSorceImageHeight:baseClassObj.height WithNewWidth:self.view.frame.size.width];
    NSLog(@"%f",cellHeight);
    // cell Height varies according to image aspect ratio.
    return cellHeight;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ImageInfoCell";
    
    ImageInfoCell *cell = (ImageInfoCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ImageInfoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
  
    BaseClass *baseClassObj = [dataArray objectAtIndex:indexPath.row];
    
    // here for downloading image asynchoronioulsly we are using open source library SDWebImage
    // https://github.com/rs/SDWebImage , Its image view category that provides the functionality to download image asynch and also provide web cachy as well , for the team purpose just need to call method with image view.
    
   [cell.img_Social sd_setImageWithURL:[NSURL URLWithString:baseClassObj.urls.full] placeholderImage:[UIImage imageNamed:@"alarm-clock"]];
    [cell.img_ProfilePic sd_setImageWithURL:[NSURL URLWithString:baseClassObj.user.profileImage.medium] placeholderImage:[UIImage imageNamed:@""]];
    cell.lbl_UserName.text = baseClassObj.user.username;
    cell.lbl_Like.text = [NSString stringWithFormat:@"%d",(int)baseClassObj.likes];
    
   // NSLog(@"%@",baseClassObj.user.profileImage);
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - scrollview Delegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    tagForScroll = currentOffset.y;
}

#pragma mark - Network Layer Delegate

- (void) from_NLGetImagesList:(id)destinationObject response:(NSDictionary*)responseDict withError:(NSError *)error
{
    dataArray = [responseDict objectForKey:@"dataArray"];
    [self.tbl_ImagesList reloadData];
    
}

@end
