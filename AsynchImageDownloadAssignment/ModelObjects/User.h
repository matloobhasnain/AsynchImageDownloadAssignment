//
//  User.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProfileImage, Links;

@interface User : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) ProfileImage *profileImage;
@property (nonatomic, strong) Links *links;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
