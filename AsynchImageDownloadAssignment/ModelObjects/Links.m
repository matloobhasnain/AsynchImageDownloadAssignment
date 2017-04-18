//
//  Links.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Links.h"


NSString *const kLinksPhotos = @"photos";
NSString *const kLinksLikes = @"likes";
NSString *const kLinksDownload = @"download";
NSString *const kLinksSelf = @"self";
NSString *const kLinksHtml = @"html";


@interface Links ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Links

@synthesize photos = _photos;
@synthesize likes = _likes;
@synthesize download = _download;
@synthesize linksSelf = _linksSelf;
@synthesize html = _html;


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
            self.photos = [self objectOrNilForKey:kLinksPhotos fromDictionary:dict];
            self.likes = [self objectOrNilForKey:kLinksLikes fromDictionary:dict];
            self.download = [self objectOrNilForKey:kLinksDownload fromDictionary:dict];
            self.linksSelf = [self objectOrNilForKey:kLinksSelf fromDictionary:dict];
            self.html = [self objectOrNilForKey:kLinksHtml fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.photos forKey:kLinksPhotos];
    [mutableDict setValue:self.likes forKey:kLinksLikes];
    [mutableDict setValue:self.download forKey:kLinksDownload];
    [mutableDict setValue:self.linksSelf forKey:kLinksSelf];
    [mutableDict setValue:self.html forKey:kLinksHtml];

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

    self.photos = [aDecoder decodeObjectForKey:kLinksPhotos];
    self.likes = [aDecoder decodeObjectForKey:kLinksLikes];
    self.download = [aDecoder decodeObjectForKey:kLinksDownload];
    self.linksSelf = [aDecoder decodeObjectForKey:kLinksSelf];
    self.html = [aDecoder decodeObjectForKey:kLinksHtml];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_photos forKey:kLinksPhotos];
    [aCoder encodeObject:_likes forKey:kLinksLikes];
    [aCoder encodeObject:_download forKey:kLinksDownload];
    [aCoder encodeObject:_linksSelf forKey:kLinksSelf];
    [aCoder encodeObject:_html forKey:kLinksHtml];
}

- (id)copyWithZone:(NSZone *)zone
{
    Links *copy = [[Links alloc] init];
    
    if (copy) {

        copy.photos = [self.photos copyWithZone:zone];
        copy.likes = [self.likes copyWithZone:zone];
        copy.download = [self.download copyWithZone:zone];
        copy.linksSelf = [self.linksSelf copyWithZone:zone];
        copy.html = [self.html copyWithZone:zone];
    }
    
    return copy;
}


@end
