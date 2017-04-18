//
//  User.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "ProfileImage.h"
#import "Links.h"


NSString *const kUserUsername = @"username";
NSString *const kUserId = @"id";
NSString *const kUserProfileImage = @"profile_image";
NSString *const kUserLinks = @"links";
NSString *const kUserName = @"name";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize username = _username;
@synthesize userIdentifier = _userIdentifier;
@synthesize profileImage = _profileImage;
@synthesize links = _links;
@synthesize name = _name;


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
            self.username = [self objectOrNilForKey:kUserUsername fromDictionary:dict];
            self.userIdentifier = [self objectOrNilForKey:kUserId fromDictionary:dict];
            self.profileImage = [ProfileImage modelObjectWithDictionary:[dict objectForKey:kUserProfileImage]];
            self.links = [Links modelObjectWithDictionary:[dict objectForKey:kUserLinks]];
            self.name = [self objectOrNilForKey:kUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:kUserUsername];
    [mutableDict setValue:self.userIdentifier forKey:kUserId];
    [mutableDict setValue:[self.profileImage dictionaryRepresentation] forKey:kUserProfileImage];
    [mutableDict setValue:[self.links dictionaryRepresentation] forKey:kUserLinks];
    [mutableDict setValue:self.name forKey:kUserName];

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

    self.username = [aDecoder decodeObjectForKey:kUserUsername];
    self.userIdentifier = [aDecoder decodeObjectForKey:kUserId];
    self.profileImage = [aDecoder decodeObjectForKey:kUserProfileImage];
    self.links = [aDecoder decodeObjectForKey:kUserLinks];
    self.name = [aDecoder decodeObjectForKey:kUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_username forKey:kUserUsername];
    [aCoder encodeObject:_userIdentifier forKey:kUserId];
    [aCoder encodeObject:_profileImage forKey:kUserProfileImage];
    [aCoder encodeObject:_links forKey:kUserLinks];
    [aCoder encodeObject:_name forKey:kUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[User alloc] init];
    
    if (copy) {

        copy.username = [self.username copyWithZone:zone];
        copy.userIdentifier = [self.userIdentifier copyWithZone:zone];
        copy.profileImage = [self.profileImage copyWithZone:zone];
        copy.links = [self.links copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
