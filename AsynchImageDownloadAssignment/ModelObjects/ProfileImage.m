//
//  ProfileImage.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ProfileImage.h"


NSString *const kProfileImageSmall = @"small";
NSString *const kProfileImageLarge = @"large";
NSString *const kProfileImageMedium = @"medium";


@interface ProfileImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProfileImage

@synthesize small = _small;
@synthesize large = _large;
@synthesize medium = _medium;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.small = [self objectOrNilForKey:kProfileImageSmall fromDictionary:dict];
            self.large = [self objectOrNilForKey:kProfileImageLarge fromDictionary:dict];
            self.medium = [self objectOrNilForKey:kProfileImageMedium fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.small forKey:kProfileImageSmall];
    [mutableDict setValue:self.large forKey:kProfileImageLarge];
    [mutableDict setValue:self.medium forKey:kProfileImageMedium];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.small = [aDecoder decodeObjectForKey:kProfileImageSmall];
    self.large = [aDecoder decodeObjectForKey:kProfileImageLarge];
    self.medium = [aDecoder decodeObjectForKey:kProfileImageMedium];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_small forKey:kProfileImageSmall];
    [aCoder encodeObject:_large forKey:kProfileImageLarge];
    [aCoder encodeObject:_medium forKey:kProfileImageMedium];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProfileImage *copy = [[ProfileImage alloc] init];
    
    if (copy) {

        copy.small = [self.small copyWithZone:zone];
        copy.large = [self.large copyWithZone:zone];
        copy.medium = [self.medium copyWithZone:zone];
    }
    
    return copy;
}


@end
