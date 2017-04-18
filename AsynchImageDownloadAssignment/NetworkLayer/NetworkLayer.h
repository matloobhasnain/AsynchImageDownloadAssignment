//
//  NetworkLayer.h
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
@protocol NetworkLayerDelegate<NSObject>

- (void) from_NLGetImagesList:(id)destinationObject response:(NSDictionary*)responseDict withError:(NSError *)error;

@end

@interface NetworkLayer : NSObject

@property (nonatomic,strong) MBProgressHUD *HUD;
@property (nonatomic, assign) id <NetworkLayerDelegate> networkLayerDelegate;

+ (NetworkLayer *)sharedNetworkLayer;
-(void)getResponseWithSourceObject:(id)sourceObject WithApiEndPoint:(NSString*)endPoint WithParams:(NSDictionary*)params;
- (void)showHUD;
- (void)removeHUD;

@end
