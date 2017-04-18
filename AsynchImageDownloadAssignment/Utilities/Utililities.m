//
//  Utililities.m
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import "Utililities.h"

@implementation Utililities

+ (id)sharedUtilities
{
    static Utililities *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
  self = [super init];
    return self;
}

- (void)dealloc
{
    
}


+(float)getImageHeightAccordingToAspectRatio:(int)sourceImageWidth WithSorceImageHeight:(int)sourceImageHeight WithNewWidth:(int)newWidth
{
    float oldWidth = sourceImageWidth;
    float scaleFactor = newWidth / oldWidth;
    float newHeight = sourceImageHeight * scaleFactor;
    return newHeight;
}

+ (BOOL)isInternetconnected
{
    if ([AFNetworkReachabilityManager sharedManager].reachable)
    {
        
        if ([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi)
            NSLog(@"Network reachable via WWAN");
        else
            NSLog(@"Network reachable via Wifi");
        
        return YES;
    }
    else
    {
        
        NSLog(@"Network is not reachable");
        return NO;
    }
}

+ (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

@end
