//
//  ImageInfoCell.m
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import "ImageInfoCell.h"

@implementation ImageInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img_ProfilePic.layer.cornerRadius = self.img_ProfilePic.frame.size.width/2;
    self.img_ProfilePic.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

@end
