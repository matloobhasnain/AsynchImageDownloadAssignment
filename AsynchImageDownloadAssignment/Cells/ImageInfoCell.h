//
//  ImageInfoCell.h
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_Social;
@property (weak, nonatomic) IBOutlet UIImageView *img_ProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lbl_UserName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Like;

@end
