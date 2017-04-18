//
//  ProfileImage.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProfileImage : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *small;
@property (nonatomic, strong) NSString *large;
@property (nonatomic, strong) NSString *medium;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
