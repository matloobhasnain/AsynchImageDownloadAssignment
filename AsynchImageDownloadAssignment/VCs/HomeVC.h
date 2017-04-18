//
//  HomeVC.h
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    UIRefreshControl *refreshControll;
    float tagForScroll;
    NSMutableArray *dataArray;
}
- (IBAction)addRefreshControl;
-(void)fetchJsonResponseFromServer;
@property (weak, nonatomic) IBOutlet UITableView *tbl_ImagesList;
@end
