//
//  Utililities.h
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utililities : NSObject

+ (Utililities *)sharedUtilities;

+ (BOOL)isInternetconnected;

+(float)getImageHeightAccordingToAspectRatio:(int)sourceImageWidth WithSorceImageHeight:(int)sourceImageHeight WithNewWidth:(int)newWidth;

+ (BOOL) validateUrl: (NSString *) candidate;
@end
