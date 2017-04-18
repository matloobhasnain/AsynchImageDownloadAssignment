//
//  BaseClass.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "Categories.h"
#import "Urls.h"
#import "Links.h"
#import "User.h"


NSString *const kBaseClassId = @"id";
NSString *const kBaseClassCategories = @"categories";
NSString *const kBaseClassCreatedAt = @"created_at";
NSString *const kBaseClassWidth = @"width";
NSString *const kBaseClassLikes = @"likes";
NSString *const kBaseClassUrls = @"urls";
NSString *const kBaseClassColor = @"color";
NSString *const kBaseClassCurrentUserCollections = @"current_user_collections";
NSString *const kBaseClassLinks = @"links";
NSString *const kBaseClassHeight = @"height";
NSString *const kBaseClassLikedByUser = @"liked_by_user";
NSString *const kBaseClassUser = @"user";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize categories = _categories;
@synthesize createdAt = _createdAt;
@synthesize width = _width;
@synthesize likes = _likes;
@synthesize urls = _urls;
@synthesize color = _color;
@synthesize currentUserCollections = _currentUserCollections;
@synthesize links = _links;
@synthesize height = _height;
@synthesize likedByUser = _likedByUser;
@synthesize user = _user;


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
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kBaseClassId fromDictionary:dict];
    NSObject *receivedCategories = [dict objectForKey:kBaseClassCategories];
    NSMutableArray *parsedCategories = [NSMutableArray array];
    if ([receivedCategories isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCategories) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCategories addObject:[Categories modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCategories isKindOfClass:[NSDictionary class]]) {
       [parsedCategories addObject:[Categories modelObjectWithDictionary:(NSDictionary *)receivedCategories]];
    }

    self.categories = [NSArray arrayWithArray:parsedCategories];
            self.createdAt = [self objectOrNilForKey:kBaseClassCreatedAt fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kBaseClassWidth fromDictionary:dict] doubleValue];
            self.likes = [[self objectOrNilForKey:kBaseClassLikes fromDictionary:dict] doubleValue];
            self.urls = [Urls modelObjectWithDictionary:[dict objectForKey:kBaseClassUrls]];
            self.color = [self objectOrNilForKey:kBaseClassColor fromDictionary:dict];
            self.currentUserCollections = [self objectOrNilForKey:kBaseClassCurrentUserCollections fromDictionary:dict];
            self.links = [Links modelObjectWithDictionary:[dict objectForKey:kBaseClassLinks]];
            self.height = [[self objectOrNilForKey:kBaseClassHeight fromDictionary:dict] doubleValue];
            self.likedByUser = [[self objectOrNilForKey:kBaseClassLikedByUser fromDictionary:dict] boolValue];
            self.user = [User modelObjectWithDictionary:[dict objectForKey:kBaseClassUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kBaseClassId];
    NSMutableArray *tempArrayForCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategories] forKey:kBaseClassCategories];
    [mutableDict setValue:self.createdAt forKey:kBaseClassCreatedAt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kBaseClassWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likes] forKey:kBaseClassLikes];
    [mutableDict setValue:[self.urls dictionaryRepresentation] forKey:kBaseClassUrls];
    [mutableDict setValue:self.color forKey:kBaseClassColor];
    NSMutableArray *tempArrayForCurrentUserCollections = [NSMutableArray array];
    for (NSObject *subArrayObject in self.currentUserCollections) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCurrentUserCollections addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCurrentUserCollections addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCurrentUserCollections] forKey:kBaseClassCurrentUserCollections];
    [mutableDict setValue:[self.links dictionaryRepresentation] forKey:kBaseClassLinks];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kBaseClassHeight];
    [mutableDict setValue:[NSNumber numberWithBool:self.likedByUser] forKey:kBaseClassLikedByUser];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kBaseClassUser];

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

    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kBaseClassId];
    self.categories = [aDecoder decodeObjectForKey:kBaseClassCategories];
    self.createdAt = [aDecoder decodeObjectForKey:kBaseClassCreatedAt];
    self.width = [aDecoder decodeDoubleForKey:kBaseClassWidth];
    self.likes = [aDecoder decodeDoubleForKey:kBaseClassLikes];
    self.urls = [aDecoder decodeObjectForKey:kBaseClassUrls];
    self.color = [aDecoder decodeObjectForKey:kBaseClassColor];
    self.currentUserCollections = [aDecoder decodeObjectForKey:kBaseClassCurrentUserCollections];
    self.links = [aDecoder decodeObjectForKey:kBaseClassLinks];
    self.height = [aDecoder decodeDoubleForKey:kBaseClassHeight];
    self.likedByUser = [aDecoder decodeBoolForKey:kBaseClassLikedByUser];
    self.user = [aDecoder decodeObjectForKey:kBaseClassUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kBaseClassId];
    [aCoder encodeObject:_categories forKey:kBaseClassCategories];
    [aCoder encodeObject:_createdAt forKey:kBaseClassCreatedAt];
    [aCoder encodeDouble:_width forKey:kBaseClassWidth];
    [aCoder encodeDouble:_likes forKey:kBaseClassLikes];
    [aCoder encodeObject:_urls forKey:kBaseClassUrls];
    [aCoder encodeObject:_color forKey:kBaseClassColor];
    [aCoder encodeObject:_currentUserCollections forKey:kBaseClassCurrentUserCollections];
    [aCoder encodeObject:_links forKey:kBaseClassLinks];
    [aCoder encodeDouble:_height forKey:kBaseClassHeight];
    [aCoder encodeBool:_likedByUser forKey:kBaseClassLikedByUser];
    [aCoder encodeObject:_user forKey:kBaseClassUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = [self.internalBaseClassIdentifier copyWithZone:zone];
        copy.categories = [self.categories copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.width = self.width;
        copy.likes = self.likes;
        copy.urls = [self.urls copyWithZone:zone];
        copy.color = [self.color copyWithZone:zone];
        copy.currentUserCollections = [self.currentUserCollections copyWithZone:zone];
        copy.links = [self.links copyWithZone:zone];
        copy.height = self.height;
        copy.likedByUser = self.likedByUser;
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
